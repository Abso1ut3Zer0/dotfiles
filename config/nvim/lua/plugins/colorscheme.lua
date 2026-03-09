return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = { italic = true },
			keywordStyle = { bold = true },
			statementStyle = { bold = true },
			typeStyle = { bold = true },
			transparent = true,
			dimInactive = false,
			terminalColors = false,
			colors = {
				palette = {},
				theme = {
					wave = {},
					lotus = {},
					dragon = {
						syn = {
							string = "#87b887",
							number = "#ff9cb4",
							constant = "#d8927b",
							identifier = "#d4bd8d",
							fun = "#E6ADC2",
							statement = "#d46767",
							keyword = "#8F98AE",
							operator = "#b2a09c",
							puct = "#b2a09c",
							comment = "#C3C3C3",
							preproc = "#d08770",
							type = "#73A9C0",
							special1 = "#d8927b",
							special2 = "#d8927b",
							special3 = "#d8927b",
						},
					},
					all = { ui = { bg_gutter = "none" } },
				},
			},
			overrides = function(colors)
				return {}
			end,
			theme = "wave",
			background = {
				dark = "dragon",
				light = "lotus",
			},
		})
		vim.cmd("colorscheme kanagawa")
	end,
}
