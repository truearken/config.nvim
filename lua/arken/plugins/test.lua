return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- adapaters
		"nvim-neotest/neotest-go",
		-- coverage
		"andythigpen/nvim-coverage",
	},
	config = function()
		require("coverage").setup()

		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-go")({
					args = { "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out" },
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
