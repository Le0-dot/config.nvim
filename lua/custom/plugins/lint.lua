return {
	{
		'mfussenegger/nvim-lint',
		dependencies = {
			'williamboman/mason.nvim',
		},
		config = function()
			local lint = require('lint')
			lint.linters_by_ft = {
				python = { 'ruff' },
			}
			local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
			vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
				group = lint_augroup,
				callback = function()
					require('lint').try_lint()
				end,
			})
		end,
	},
	{
		'rshkarin/mason-nvim-lint',
		dependencies = {
			'williamboman/mason.nvim',
			'mfussenegger/nvim-lint',
		},
		opts = {
			automatic_installation = true,
		},
	},
}
