local vim = vim

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.cursorcolumn = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.termguicolors = true

vim.g.mapleader = " "

-- Keybinding to load the current file
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-mini/mini.completion" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("which-key").setup()
vim.keymap.set("n", "<leader>?", function() require("which-key").show({ global = false }) end,
	{ desc = "Buffer Local Keymaps (which-key)" })

require("mason").setup()
require("mason-lspconfig").setup()
-- vim.lsp.enable({ "lua_ls", "nil_ls", "rust-analyzer" })

-- Setup LSP keybindings
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover documentation" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "rename symbol" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "open code actions" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format current buffer" })

require("snacks").setup({
	picker = { enable = true },
})
vim.keymap.set('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = "open smart picker" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "go to references" })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "go to implementation" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "find files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "find grep" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "find buffers" })

require("mini.completion").setup()
require("mini.icons").setup()

vim.keymap.set("i", "jj", "<ESC>", { desc = "exit insert mode", silent = true })
vim.keymap.set("n", "<Tab>", "<cmd>bNext<CR>", { desc = "next buffer" })

require("nvim-treesitter").setup()

vim.cmd("colorscheme catppuccin-mocha")
vim.cmd(":hi statusline guibg=NONE")

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", '<leader>y', '"+y', { noremap = true, silent = true, desc = 'yank to clipboard' })
vim.keymap.set({ "v", "x" }, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'yank to clipboard' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'paste from clipboard' })
vim.keymap.set('i', '<C-p>', '<C-r>+',
	{ noremap = true, silent = true, desc = 'paste from clipboard from within insert mode' })
