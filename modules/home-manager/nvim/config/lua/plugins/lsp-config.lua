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

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities
			})
			lspconfig.jdtls.setup({
				capabilities = capabilities
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities
			})
			lspconfig.nil_ls.setup({
				capabilities = capabilities
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover documentation" })
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "rename symbol" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "open code actions" })
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "go to references" }) -- Find references for the word under your cursor
			-- vim.api.nvim_create_autocmd("LspAttach", {
			-- 	callback = function(event)
			-- 		local map = function(keys, func, desc)
			-- 			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			-- 		end
			-- 	end,
			-- })
		end,
	},
}
