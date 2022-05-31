local M = {}

M.nremap = function(key, vscode_command)
	vim.api.nvim_set_keymap(
		'n',
		key,
		[[<cmd>call VSCodeCall(']] .. vscode_command .. [[')<cr>]],
		{ silent = true, noremap = true }
	)
end

return M
