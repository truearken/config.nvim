return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "tl", "<cmd>diffget //2<CR>")
		vim.keymap.set("n", "tr", "<cmd>diffget //3<CR>")
	end,
}
