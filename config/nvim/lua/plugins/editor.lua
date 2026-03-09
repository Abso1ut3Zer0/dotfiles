return {
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undotree" },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "│" },
			whitespace = { remove_blankline_trail = false },
			scope = { enabled = false },
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"jpalardy/vim-slime",
		init = function()
			vim.g.slime_target = "tmux"
			vim.g.slime_no_mappings = 1
			vim.g.slime_bracketed_paste = 1
			vim.g.slime_python_ipython = 0
		end,
		keys = {
			{ "<leader>rp", "<Plug>SlimeRegionSend", mode = "v", desc = "Send region to tmux" },
		},
	},
}
