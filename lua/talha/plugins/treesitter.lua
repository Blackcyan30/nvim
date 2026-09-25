local parsers = {
	"javascript", "typescript", "tsx", "python", "c", "cpp", "java", "go",
	"diff", "luadoc", "fsharp", "json", "yaml", "html", "css", "prisma",
	"markdown", "markdown_inline", "svelte", "graphql", "bash", "lua", "vim",
	"dockerfile", "gitignore", "query", "vimdoc",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = function()
		require("nvim-treesitter").install(parsers):wait(300000)
	end,
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("nvim-treesitter").setup()

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if lang and vim.tbl_contains(parsers, lang) then
					vim.treesitter.start(args.buf, lang)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
