return {
	{
		"lervag/vimtex",
		ft = "tex",
		init = function()
			if vim.fn.has("mac") == 1 then
				vim.g.vimtex_view_method = "skim"
			end
			vim.g.vimtex_compiler_progname = "nvr"
			vim.g.vimtex_syntax_enabled = 0
		end,
	},
	{
		"tpope/vim-dadbod",
		cmd = "DB",
	},
}
