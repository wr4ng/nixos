---@diagnostic disable: undefined-global

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

vim.pack.add({
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	'https://github.com/nvim-mini/mini.completion',
	{ src = 'https://github.com/catppuccin/nvim', name = "catppuccin" },
	'https://github.com/folke/which-key.nvim',
	'https://github.com/folke/snacks.nvim',
	'https://github.com/lewis6991/gitsigns.nvim',
	{
		src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
		version = vim.version.range('3')
	},
	-- neo-tree.nvim dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/sphamba/smear-cursor.nvim",
})

vim.cmd.colorscheme("catppuccin-mocha")

require("mason").setup()
require("mason-lspconfig").setup()
require("mini.completion").setup()

vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")

require("which-key").setup()
vim.opt.timeout = true
vim.opt.timeoutlen = 300

require("gitsigns").setup()
require("snacks").setup({
	picker = {
		enabled = true,
	},
	lazygit = {},
	styles = {
		lazygit = {
			width = 0.95,
			height = 0.95,
		},
	},
})

require('smear_cursor').setup({})

vim.keymap.set("i", "jj", "<ESC>", { desc = "exit insert mode", silent = true })
vim.keymap.set("n", "<Tab>", "<cmd>bNext<CR>", { desc = "next buffer" })

-- Diagnostic keymaps
vim.diagnostic.config({ virtual_text = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

local function toggle_diagnostics()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

vim.keymap.set('n', '<leader>dd', toggle_diagnostics, { desc = 'Toggle diagnostics' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Clipboard
vim.keymap.set("n", '<leader>y', '"+y', { noremap = true, silent = true, desc = 'yank to clipboard' })
vim.keymap.set({ "v", "x" }, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'yank to clipboard' })
vim.keymap.set({ "n", "v", "x" }, '<C-a>', 'gg0vG$', { noremap = true, silent = true, desc = 'select all' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'paste from clipboard' })
vim.keymap.set('i', '<C-p>', '<C-r>+',
	{ noremap = true, silent = true, desc = 'paste from clipboard from within insert mode' })

-- LSP
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
vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "find buffers" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "find buffers" })

-- Disable mini.completion in Snacks picker window
vim.api.nvim_create_autocmd("FileType", {
	pattern = "snacks_picker_input",
	desc = "Disable mini.completion for snacks picker",
	group = vim.api.nvim_create_augroup("user_mini", {}),
	command = "lua vim.b.minicompletion_disable=true",
})

-- neo-tree.nvim
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")
require('neo-tree').setup({
	enable_git_status = true,
	enable_diagnostics = true,
	window = {
		position = "right",
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
	},
})
