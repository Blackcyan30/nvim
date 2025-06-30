return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- LSP keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				local keymap = vim.keymap

				-- LSP keymaps
				opts.desc = "Go to definition"
				keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				opts.desc = "Go to references"
				keymap.set("n", "gr", vim.lsp.buf.references, opts)
				opts.desc = "Go to implementation"
				keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				opts.desc = "Show documentation"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				opts.desc = "Rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				opts.desc = "Code action"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			end,
		})

		-- Diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Capabilities
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Mason setup
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Mason tool installer
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- JavaScript/TypeScript
				"prettier",
				"eslint_d",
				"typescript-language-server",

				-- Python
				"black",
				"isort",
				"pylint",
				"pyright",

				-- C/C++
				"clangd",
				"clang-format",

				-- Java
				"jdtls",

				-- Go
				"gopls",
				"goimports",
				"gofumpt",
				"golangci-lint",

				-- Lua
				"stylua",

				-- General
				"prettier",
			},
		})

		-- LSP configs
		local lspconfig = require("lspconfig")

		-- TypeScript/JavaScript LSP
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		})

		-- Lua LSP
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					diagnostics = { globals = { "vim" } },
				},
			},
		})

		-- Python LSP
		lspconfig.pyright.setup({
			capabilities = capabilities,
		})

		-- C/C++ LSP
		lspconfig.clangd.setup({
			capabilities = capabilities,
			cmd = { "clangd", "--fallback-style=none", "--header-insertion=never" },
		})

		-- Java LSP
		lspconfig.jdtls.setup({
			capabilities = capabilities,
		})

		-- Go LSP
		lspconfig.gopls.setup({
			capabilities = capabilities,
		})

		-- Svelte LSP
		lspconfig.svelte.setup({
			capabilities = capabilities,
			on_attach = function(client, _)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		-- GraphQL LSP
		lspconfig.graphql.setup({
			capabilities = capabilities,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- Emmet LSP
		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- HTML LSP
		lspconfig.html.setup({
			capabilities = capabilities,
		})

		-- CSS LSP
		lspconfig.cssls.setup({
			capabilities = capabilities,
		})

		-- Tailwind CSS LSP
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
		})
	end,
}
