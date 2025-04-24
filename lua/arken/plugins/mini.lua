return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.icons").setup()
		require("mini.diff").setup()
		local statusline = require("mini.statusline")
		statusline.section_git = function()
			return "%{FugitiveStatusline()}"
		end
		statusline.setup()
	end,
}
