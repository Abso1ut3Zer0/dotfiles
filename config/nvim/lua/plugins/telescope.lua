return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					preview_cutoff = 0,
					horizontal = {
						preview_width = 0.55,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				}
			},
		})
		telescope.load_extension("file_browser")
		telescope.load_extension("ui-select")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>k", vim.lsp.buf.code_action, { desc = "Code Action" })
		vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<CR>")
		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep)
		vim.keymap.set("n", "<leader>fh", builtin.help_tags)
		vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find)
		vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols)
		vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols)
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
		vim.keymap.set("n", "<leader>gc", builtin.git_commits)
		vim.keymap.set("n", "<leader>gb", builtin.git_branches)
	end,
}
