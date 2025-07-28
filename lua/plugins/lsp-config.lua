return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"mfussenegger/nvim-jdtls",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Manually register ts_ls if not defined
			local configs = require("lspconfig.configs")
			if not configs.ts_ls then
				configs.ts_ls = {
					default_config = {
						cmd = { "typescript-language-server", "--stdio" },
						filetypes = {
							"typescript",
							"typescriptreact",
							"typescript.tsx",
							"javascript",
							"javascriptreact",
						},
						root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
						settings = {},
					},
				}
			end

			-- Setup ts_ls (TypeScript LSP)
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			-- Lua LSP
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						format = {
							enable = true,
							defaultConfig = {
								indent_style = "space",
								indent_size = "4",
							},
						},
					},
				},
			})

			-- Java LSP
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					local jdtls = require("jdtls")
					local workspace_dir = vim.fn.stdpath("data")
						.. "/site/java/workspace-root/"
						.. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

					jdtls.start_or_attach({
						cmd = { "jdtls" },
						root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
						capabilities = capabilities,
						workspace_folder = workspace_dir,
					})
				end,
			})

			-- Keybindings
			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }
			map("n", "K", vim.lsp.buf.hover, opts)
			map("n", "<Leader>gd", vim.lsp.buf.definition, opts)
			map("n", "<Leader>gr", vim.lsp.buf.references, opts)
			map("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
			map("n", "<Leader>rn", vim.lsp.buf.rename, opts)
			map("n", "<Leader>gf", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
		end,
	},
}
