return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "auto",
			component_separators = "",
			section_separators = "",
		},
		sections = {
			lualine_a = {},
			lualine_b = { "branch" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "diagnostics" },
			lualine_y = { "filetype" },
			lualine_z = {},
		},
	},
}
