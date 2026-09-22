-- Use the Catppuccin Mocha palette used by the other terminal tools.
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		opts = {
			flavour = "mocha",
			background = {
				dark = "mocha",
			},
			auto_integrations = true,
		},
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin-mocha",
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					explorer = {
						icons = {
							tree = {
								vertical = "│  ",
								middle = "├─ ",
								last = "└─ ",
							},
						},
						layout = {
							preset = "sidebar",
							preview = false,
							layout = {
								width = 34,
								min_width = 34,
							},
						},
					},
				},
			},
		},
	},
}
