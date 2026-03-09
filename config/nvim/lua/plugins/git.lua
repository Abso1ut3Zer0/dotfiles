return {
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				integrations = {
					diffview = true,
				},
				kind = "tab",
			})

			vim.keymap.set("n", "<leader>ng", function() neogit.open() end)
			vim.keymap.set("n", "<leader>nc", function() neogit.open({ "commit" }) end)
			vim.keymap.set("n", "<leader>nb", function() neogit.open({ "branch" }) end)
			vim.keymap.set("n", "<leader>nl", function() neogit.open({ "log" }) end)
			vim.keymap.set("n", "<leader>np", function() neogit.open({ "pull" }) end)
			vim.keymap.set("n", "<leader>nP", function() neogit.open({ "push" }) end)
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>do", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" },
			{ "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Diffview close" },
			{ "<leader>df", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (current)" },
			{ "<leader>dh", "<cmd>DiffviewFileHistory<CR>", desc = "File history (all)" },
		},
		opts = {
			enhanced_diff_hl = true,
			use_icons = true,
			icons = {
				folder_closed = "",
				folder_open = "",
			},
			signs = {
				fold_closed = "",
				fold_open = "",
			},
			file_panel = {
				win_config = {
					position = "left",
					width = 35,
				},
				listing_style = "tree",
			},
		},
	},
	{
		"polarmutex/git-worktree.nvim",
		version = "^2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("git_worktree")

			vim.keymap.set("n", "<leader>ts",
				"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>")
			vim.keymap.set("n", "<leader>tn",
				"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>")
		end,
	},
}
