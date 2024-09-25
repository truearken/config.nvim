return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.icons").setup()
		require("mini.statusline").setup()
		require("mini.diff").setup()
	end,
}
