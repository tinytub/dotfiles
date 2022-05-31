local util = require "lspconfig.util"
return {
	root_dir = function(fname)
		local Path = require("plenary.path")

		local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
		local absolute_fname = Path:new(fname):absolute()

		if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
			return absolute_cwd
		end

		return util.root_pattern("go.mod", ".git")(fname)
	end,
	settings = {
		gopls = {
            analyses = {
                fillstruct = true, -- 关闭自动填充 struct. 默认打开
                unusedparams = true
            },
            staticcheck = true,
			codelenses = { test = true },
		},
	},
	flags = {
		debounce_text_changes = 200,
	},
    init_options = {
        usePlaceholders = false, -- 填充补全后的 functions param. 默认打开
        completeUnimported = true,
        --gofumpt = false,
        --hoverKind = "SingleLine",
        --hoverKind = "Structured",
        staticcheck = false,
        deepCompletion = true,
        --allowModfileModifications=true
    },
}
