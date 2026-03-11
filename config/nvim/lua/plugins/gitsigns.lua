return {
	"lewis6991/gitsigns.nvim",
	opts = {
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local opts = { buffer = bufnr }

			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then return "]c" end
				vim.schedule(function() gs.nav_hunk("next") end)
				return "<Ignore>"
			end, { buffer = bufnr, expr = true })

			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then return "[c" end
				vim.schedule(function() gs.nav_hunk("prev") end)
				return "<Ignore>"
			end, { buffer = bufnr, expr = true })

			vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
			vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
			vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts)
			vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
			vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, opts)
		end,
	},
}
