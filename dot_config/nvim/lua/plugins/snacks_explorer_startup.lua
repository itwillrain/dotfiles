return {
	{
		"folke/snacks.nvim",
		init = function()
			vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter" }, {
				callback = function(event)
					vim.schedule(function()
						if not vim.api.nvim_buf_is_valid(event.buf) or vim.bo[event.buf].buftype ~= "" then
							return
						end

						local file = vim.api.nvim_buf_get_name(event.buf)
						if file == "" then
							return
						end

						local root = LazyVim.root()
						local git_marker = root .. "/.git"
						if vim.fn.isdirectory(git_marker) == 0 and vim.fn.filereadable(git_marker) == 0 then
							return
						end

						if #Snacks.picker.get({ source = "explorer" }) == 0 then
							Snacks.explorer({ cwd = root, enter = false })
						end
					end)
				end,
			})
		end,
	},
}
