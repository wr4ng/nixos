return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "clangd" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup LSP servers (need to be installed by Mason)
			local lsp_servers = { 'lua_ls', 'gopls', 'clangd', 'jdtls', 'rust_analyzer', 'nil_ls', 'ts_ls' }
			for _, server in pairs(lsp_servers)
			do
				require("lspconfig")[server].setup {
					capabilities = capabilities
				}
			end

			-- Setup LSP keybindings
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover documentation" })
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "rename symbol" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "open code actions" })
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "go to references" }) -- Find references for the word under your cursor
		end,
	},
}
