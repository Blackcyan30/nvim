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
		local configure = function(name, config)
			vim.lsp.config(name, config)
			vim.lsp.enable(name)
		end

		-- TypeScript/JavaScript LSP
		configure("ts_ls", {
			capabilities = capabilities,
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		})

		-- Lua LSP
		configure("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					diagnostics = { globals = { "vim" } },
				},
			},
		})

		-- Python LSP
		--
		local on_attach = function(client, bufnr)
			if client.name == "pyright" then
				client.server_capabilities.semanticTokensProvider = nil
			end
		end

		configure("pyright", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		configure("pyright", {
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic", -- or "off" if you want very quiet
						diagnosticSeverityOverrides = {
							reportUnusedImport = "none",
							reportUnusedVariable = "none",
							reportUnusedFunction = "none",
							reportUnusedClass = "none",
							reportUnusedParameter = "none",
						},
					},
				},
			},
		})

		-- C/C++ LSP
		configure("clangd", {
			capabilities = capabilities,
			cmd = { "clangd", "--fallback-style=none", "--header-insertion=never" },
			-- init_options = { fallbackFlags = { "-std=c++23" } },
		})

		-- Java LSP
		configure("jdtls", {
			capabilities = capabilities,
		})

		-- Go LSP
		configure("gopls", {
			capabilities = capabilities,
		})

		-- Svelte LSP
		configure("svelte", {
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
		configure("graphql", {
			capabilities = capabilities,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- Emmet LSP
		configure("emmet_ls", {
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- HTML LSP
		configure("html", {
			capabilities = capabilities,
		})

		-- CSS LSP
		configure("cssls", {
			capabilities = capabilities,
		})

		-- Tailwind CSS LSP
		configure("tailwindcss", {
			capabilities = capabilities,
		})

		-- Metal Shading Language support activates only when the separately installed
		-- metal-lsp executable is available (it requires macOS and Xcode tools).
		vim.filetype.add({ extension = { metal = "metal" } })
		if vim.fn.executable("metal-lsp") == 1 then
			configure("metal_lsp", {
				cmd = { "metal-lsp" },
				filetypes = { "metal" },
				root_markers = { ".git", "Package.swift", ".xcodeproj" },
				capabilities = capabilities,
			})
		end
	end,
}
