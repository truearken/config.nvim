require("arken.set")
require("arken.remap")
require("arken.lazy")

local autogrp = vim.api.nvim_create_augroup
local arken_group = autogrp("arken", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = autogrp("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("LspAttach", {
	group = arken_group,
	callback = function(event)
		local map = function(keys, func, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf })
		end

		local builtin = require("telescope.builtin")
		map("gd", builtin.lsp_definitions)
		map("gr", builtin.lsp_references)
		map("gI", builtin.lsp_implementations)
		map("<leader>ds", builtin.lsp_document_symbols)
		map("<leader>ws", builtin.lsp_dynamic_workspace_symbols)
		map("<leader>rn", vim.lsp.buf.rename)
		map("<leader>ca", vim.lsp.buf.code_action, { "n", "x" })
		map("<C-k>", vim.lsp.buf.signature_help, { "i" })
		map("[d", vim.diagnostic.goto_next)
		map("]d", vim.diagnostic.goto_prev)
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
