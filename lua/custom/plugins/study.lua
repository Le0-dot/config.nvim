return {
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		'tris203/precognition.nvim',
		config = function()
			require("precognition").setup()
			require("precognition").toggle()
		end
	},
}
