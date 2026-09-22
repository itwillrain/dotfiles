return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
				component_separators = "",
				section_separators = { left = "", right = "" },
			})
			return opts
		end,
	},
}
