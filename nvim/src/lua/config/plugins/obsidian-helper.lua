return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/obsidian-helper.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{ "<leader>o", "<CMD>ObsidianHelper create<CR>", desc = "[O]bsidian create file" },
		},
		config = function()
			require("obsidian_helper").setup()
		end,
	},
}
