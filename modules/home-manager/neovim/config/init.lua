local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.wrap = false
-- vim.opt.breakindent = true

vim.g.have_nerd_font = true
vim.opt.mouse = "a"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

require("lazy").setup({
	spec = {
		{
			"catppuccin/nvim",
			lazy = false,
			priority = 1000,
			config = function()
				-- Custom comment coloring
				-- require("catppuccin").setup({
				--   custom_highlights = function(colors)
				--     return {
				--       Comment = { fg = colors.flamingo },
				--     }
				--   end,
				-- })
				vim.cmd([[colorscheme catppuccin-mocha]])
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "?" },
					changedelete = { text = "~" },
				},
			},
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
			opts = {
			},
		},
		{
			"folke/snacks.nvim",
			opts = {
				picker = {
					enable = true,
				}
			},
		},
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				ensure_installed = {},
			},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
		},
		{
			"nvim-mini/mini.icons",
			opts = {},
		},
		{
			"nvim-mini/mini.completion",
			opts = {},
		},
		{
			'nvim-treesitter/nvim-treesitter',
			lazy = false,
			build = ':TSUpdate'
		},
		{
			"ruifm/gitlinker.nvim",
			opts = {},
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
	},
	checker = { enabled = true },
})

vim.lsp.enable("nil_ls")
vim.lsp.enable("lua_ls")

vim.keymap.set("i", "jj", "<ESC>", { desc = "exit insert mode", silent = true })

-- diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- clipboard
vim.keymap.set("n", '<leader>y', '"+y', { noremap = true, silent = true, desc = 'yank to clipboard' })
vim.keymap.set({ "v", "x" }, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'yank to clipboard' })
vim.keymap.set({ "n", "v", "x" }, '<C-a>', 'gg0vG$', { noremap = true, silent = true, desc = 'select all' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'paste from clipboard' })
vim.keymap.set('i', '<C-p>', '<C-r>+',
	{ noremap = true, silent = true, desc = 'paste from clipboard from within insert mode' })

-- lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover documentation" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "rename symbol" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "go to definition" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "open code actions" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format current buffer" })

-- snacks.nvim
vim.keymap.set('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = "open smart picker" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "go to references" })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "go to implementation" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "find files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "find grep" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "find buffers" })

-- gitlinker
vim.api.nvim_set_keymap('n', '<leader>gb',
	'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
	{ silent = true })
vim.api.nvim_set_keymap('v', '<leader>gb',
	'<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
	{})
