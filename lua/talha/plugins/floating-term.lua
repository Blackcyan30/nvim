-- return {
-- 	"akinsho/toggleterm.nvim",
-- 	version = "*",
-- 	config = function()
-- 		require("toggleterm").setup({
-- 			size = 20,
-- 			open_mapping = [[<c-\>]],
-- 			direction = "float",
-- 			float_opts = {
-- 				border = "rounded",
-- 				winblend = 3,
-- 			},
-- 		})
-- 	end,
-- }
-- return {
-- 	{
-- 		"akinsho/toggleterm.nvim",
-- 		version = "*",
-- 		opts = {
-- 			size = 20,
-- 			direction = "float",
-- 			float_opts = { border = "rounded", winblend = 3 },
-- 			-- no open_mapping here
-- 		},
-- 		keys = {
-- 			{
-- 				"<C-/>",
-- 				"<cmd>ToggleTerm<cr>",
-- 				mode = "n",
-- 				desc = "Toggle floating terminal",
-- 			},
-- 			{
-- 				"<C-/>",
-- 				"<cmd>ToggleTerm<cr>",
-- 				mode = "t",
-- 				desc = "Toggle floating terminal (in terminal mode)",
-- 			},
-- 		},
-- 	},
-- }
return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		-- load on either the command or your keypress
		cmd = "ToggleTerm",
		config = function()
			require("toggleterm").setup({
				size = 20,
				direction = "float",
				float_opts = { border = "rounded", winblend = 3 },
			})
		end,
	},
}
