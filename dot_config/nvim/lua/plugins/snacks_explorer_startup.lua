return {
	{
		"folke/snacks.nvim",
		init = function()
			local function open_explorer(root)
				if not root or root == "" then
					return
				end

				local git_marker = root .. "/.git"
				if vim.fn.isdirectory(git_marker) == 0 and vim.fn.filereadable(git_marker) == 0 then
					return
				end

				if #Snacks.picker.get({ source = "explorer" }) == 0 then
					Snacks.explorer({ cwd = root, enter = false })
				end
			end

			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function(event)
					vim.schedule(function()
						if not vim.api.nvim_buf_is_valid(event.buf) or vim.bo[event.buf].buftype ~= "" then
							return
						end

						local file = vim.api.nvim_buf_get_name(event.buf)
						if file == "" then
							return
						end

						open_explorer(LazyVim.root())
					end)
				end,
			})

			vim.api.nvim_create_autocmd("DirChanged", {
				callback = function()
					vim.schedule(function()
						open_explorer(LazyVim.root())
					end)
				end,
			})
		end,
	},
}
