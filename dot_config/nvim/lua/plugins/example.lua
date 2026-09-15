-- Use the Monokai palette used by the other terminal tools.
return {
	{
		"tanvirtin/monokai.nvim",
		priority = 1000,
		opts = {
			italics = false,
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				local monokai = require("monokai")
				local palette = vim.tbl_extend("force", monokai.classic, {
					base1 = "#272822",
					base2 = "#272822",
				})
				monokai.setup({
					italics = false,
					palette = palette,
				})

				for group, color in pairs({
					MiniIconsAzure = palette.aqua,
					MiniIconsBlue = palette.aqua,
					MiniIconsCyan = palette.aqua,
					MiniIconsGreen = palette.green,
					MiniIconsGrey = palette.base6,
					MiniIconsOrange = palette.orange,
					MiniIconsPurple = palette.purple,
					MiniIconsRed = palette.pink,
					MiniIconsYellow = palette.yellow,
				}) do
					vim.api.nvim_set_hl(0, group, { fg = color })
				end
			end,
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					explorer = {
						icons = {
							files = {
								dir = " ",
								dir_open = " ",
								file = " ",
							},
							tree = {
								vertical = "│ ",
								middle = "├─",
								last = "└─",
							},
						},
					},
				},
			},
		},
	},
}
