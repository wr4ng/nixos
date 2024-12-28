return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({}) -- REQUIRED

		-- keybinds
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "harpoon: add current file"})
		vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "harpoon: open harpoon" })

		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "harpoon: go to 1" })
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "harpoon: go to 2" })
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "harpoon: go to 3" })
		vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "harpoon: go to 4" })
	end,
}
