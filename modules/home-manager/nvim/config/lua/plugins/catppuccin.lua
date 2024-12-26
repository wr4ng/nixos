return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		-- Change comment color
		require("catppuccin").setup({
			custom_highlights = function(colors)
				return {
					Comment = { fg = colors.flamingo },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
