return {
	{
		"hat0uma/csvview.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle", "CsvViewInfo" },
		opts = {
			view = {
				display_mode = "border",
				sticky_header = { enabled = true },
			},
		},
		config = function(_, opts)
			local csvview = require("csvview")
			csvview.setup(opts)

			local group = vim.api.nvim_create_augroup("csvview_auto_enable", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = { "csv", "tsv" },
				callback = function(event)
					csvview.enable(event.buf)
				end,
			})

			if vim.tbl_contains({ "csv", "tsv" }, vim.bo.filetype) then
				csvview.enable(0)
			end
		end,
	},
}
