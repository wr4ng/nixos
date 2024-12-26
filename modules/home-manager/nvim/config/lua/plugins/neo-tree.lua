return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window
	},
	config = function()
		vim.keymap.set("n", "<leader>n", "<Cmd>Neotree filesystem reveal left<CR>", { desc = "neotree: open" })
		vim.keymap.set("n", "<leader>b", "<Cmd>Neotree toggle<CR>", { desc = "neotree: toggle" })
	end,
}
