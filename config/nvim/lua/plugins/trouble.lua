return {
	"folke/trouble.nvim",
	opts = {},
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>xd", "<cmd>Trouble lsp_document_symbols toggle<cr>", desc = "Document Symbols (Trouble)" },
	},
}
