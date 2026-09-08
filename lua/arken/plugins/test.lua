return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		-- adapaters
		-- "nvim-neotest/neotest-go",
		{
			"nvim-treesitter/nvim-treesitter", -- Optional, but recommended
			branch = "main", -- NOTE; not the master branch!
			build = function()
				vim.cmd(":TSUpdate go")
			end,
		},
		{
			"fredrikaverpil/neotest-golang",
			version = "*", -- Optional, but recommended; track releases
			build = function()
				vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
			end,
		},
		-- coverage
		"andythigpen/nvim-coverage",
	},
	config = function()
		require("coverage").setup({
			auto_reload = true,
			lang = {
				go = {
					coverage_file = "/tmp/coverage.out",
				},
			},
		})

		local function go_test_args()
			local dir = vim.fn.expand("%:p:h")
			local args = { "-v", "-count=1", "-coverprofile=/tmp/coverage.out" }
			local res = vim.system({ "go", "list", "-m" }, { cwd = dir, text = true }):wait()
			if res.code == 0 then
				table.insert(args, "-coverpkg=" .. vim.trim(res.stdout) .. "/...")
			end
			return args
		end

		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-golang")({
					go_test_args = go_test_args(),
				}),
			},
		})

		vim.keymap.set("n", "<leader>tc", function()
			neotest.run.run()
		end)

		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end)

		vim.keymap.set("n", "<leader>ts", function()
			neotest.run.stop()
		end)
	end,
}
