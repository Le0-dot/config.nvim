return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	build = ':TSUpdate',
	opts = {
		ensure_installed = { "cpp", "python", "robot", "haskell", },
		auto_install = true,

		highlight = { enable = true },
		indent = { enable = true },
	}
}
