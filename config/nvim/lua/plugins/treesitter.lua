return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			ensure_installed = {
				"javascript", "typescript", "java", "json", "yaml", "proto",
				"python", "go", "rust", "zig", "elixir", "heex", "eex",
				"c", "cpp", "html", "http", "solidity", "lua",
				"vim", "vimdoc", "query", "gitcommit", "git_rebase",
				"markdown", "markdown_inline",
			},
			sync_install = false,
			auto_install = true,
		})

		-- Enable treesitter highlighting for all buffers
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
