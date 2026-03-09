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
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
