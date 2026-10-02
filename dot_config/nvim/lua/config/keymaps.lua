-- Keep the insert-mode escape shortcuts from the previous init.vim.
vim.keymap.set("i", "jj", "<Esc>", { silent = true })
vim.keymap.set("i", "っj", "<Esc>", { silent = true })

-- Open the current file in leaf (Markdown viewer) in a floating terminal.
vim.keymap.set("n", "<leader>ml", function()
	vim.cmd("silent write")
	Snacks.terminal({ "leaf", vim.fn.expand("%:p") }, { win = { style = "float" } })
end, { desc = "Open in leaf" })

-- Toggle a herdr pane running a command for the current file.
-- `panes` keeps one pane id per kind so each kind toggles independently.
local panes = {}
local function toggle_herdr_pane(kind, direction, command)
	return function()
		if not vim.env.HERDR_ENV then
			return vim.notify("herdr の中で nvim を起動していません", vim.log.levels.WARN)
		end
		if panes[kind] then
			vim.system({ "herdr", "pane", "close", panes[kind] }):wait()
			panes[kind] = nil
			return
		end
		vim.cmd("silent write")
		local split = vim.system({ "herdr", "pane", "split", "--current", "--direction", direction, "--no-focus" }, { text = true }):wait()
		local ok, res = pcall(vim.json.decode, split.stdout)
		if not ok then
			return vim.notify("herdr pane split に失敗しました", vim.log.levels.ERROR)
		end
		panes[kind] = res.result.pane.pane_id
		vim.system({ "herdr", "pane", "run", panes[kind], command .. " " .. vim.fn.shellescape(vim.fn.expand("%:p")) }):wait()
	end
end
vim.keymap.set("n", "<leader>mw", toggle_herdr_pane("leaf", "right", "leaf --watch"), { desc = "Toggle leaf --watch pane (right)" })
vim.keymap.set("n", "<leader>mW", toggle_herdr_pane("leaf", "down", "leaf --watch"), { desc = "Toggle leaf --watch pane (down)" })
vim.keymap.set("n", "<leader>mm", toggle_herdr_pane("mermaid", "down", "mermaid"), { desc = "Toggle mermaid pane (down)" })
