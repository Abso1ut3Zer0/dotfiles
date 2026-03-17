return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- LSP keybindings on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf }

						vim.api.nvim_set_hl(0, "@lsp.type.typeAlias.rust", { link = "Type" })
					vim.api.nvim_set_hl(0, "@lsp.typemod.typeAlias.library.rust", { link = "Type" })

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", opts)
					vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>fm", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>qr", "<cmd>cclose<CR>", opts)

					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
					vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
					vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
				end,
			})

			-- Autoformat on save
			local format_is_enabled = true
			vim.api.nvim_create_user_command("FormatToggle", function()
				format_is_enabled = not format_is_enabled
				print("Autoformatting: " .. tostring(format_is_enabled))
			end, {})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-autoformat", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client or not client.server_capabilities.documentFormattingProvider then
						return
					end

					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup(
							"lsp-format-" .. client.name,
							{ clear = true }
						),
						buffer = args.buf,
						callback = function()
							if not format_is_enabled then
								return
							end
							vim.lsp.buf.format({
								async = false,
								filter = function(c)
									return c.id == client.id
								end,
							})
						end,
					})
				end,
			})

			-- Diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = true,
				},
			})

			-- Mason
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"eslint",
					"rust_analyzer",
					"clangd",
					"lua_ls",
					"gopls",
					"pylsp",
					"sqlls",
					"zls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["rust_analyzer"] = function()
						require("lspconfig").rust_analyzer.setup({
							capabilities = capabilities,
							settings = {
								["rust-analyzer"] = {
									diagnostics = {
										enable = true,
										enableExperimental = true,
									},
									checkOnSave = { command = "clippy" },
									procMacro = { enable = true },
									cargo = {
										allFeatures = true,
										loadOutDirsFromCheck = true,
									},
								},
							},
						})
					end,
					["pylsp"] = function()
						require("lspconfig").pylsp.setup({
							capabilities = capabilities,
							settings = {
								pylsp = {
									plugins = {
										pycodestyle = { maxLineLength = 120 },
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
