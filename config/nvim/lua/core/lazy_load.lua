local M = {}
-- https://github.com/max397574/omega-nvim/blob/master/lua/omega/modules/ui/bufferline.lua
M.lazy_load = function(tb)
  vim.api.nvim_create_autocmd(tb.events, {
    group = vim.api.nvim_create_augroup(tb.augroup_name, {}),
    callback = function()
      if tb.condition() then
        vim.api.nvim_del_augroup_by_name(tb.augroup_name)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if tb.plugin ~= "nvim-treesitter" then
          vim.defer_fn(function()
            require("packer").loader(tb.plugin)
            if tb.plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("packer").loader(tb.plugin)
        end
      end
    end,
  })
end


M.bufferline = function()
  M.lazy_load {
    events = { "BufNewFile", "BufRead", "TabEnter" },
    augroup_name = "BufferLineLazy",
    plugins = "bufferline.nvim",

    condition = function()
      return #vim.fn.getbufinfo { buflisted = 1 } >= 2
    end,
  }
end

M.colorizer = function()
  M.lazy_load {
    events = { "BufRead", "BufNewFile" },
    augroup_name = "ColorizerLazy",
    plugins = "nvim-colorizer.lua",

    condition = function()
      return true
    end,
  }
end

-- load certain plugins only when there's a file opened in the buffer
-- if "nvim-filename" is executed -> load the plugin after nvim gui loads
-- This gives an instant preview of nvim with the file opened

M.on_file_open = function(plugin_name)
  M.lazy_load {
    events = { "BufRead", "BufWinEnter", "BufNewFile" },
    augroup_name = "BeLazyOnFileOpen" .. plugin_name,
    plugin = plugin_name,
    condition = function()
      local file = vim.fn.expand "%"
      return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
    end,
  }
end

M.treesitter = function()
  M.lazy_load {
    events = { "BufRead", "BufWinEnter", "BufNewFile" },
    augroup_name = "Treesitter_lazy",
    plugins = "nvim-treesitter",

    condition = function()
      local file = vim.fn.expand "%"
      return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
    end,
  }
end

M.mason_cmds = {
  "Mason",
  "MasonInstall",
  "MasonInstallAll",
  "MasonUninstall",
  "MasonUninstallAll",
  "MasonLog",
}

M.packer_cmds = {
  "PackerSnapshot",
  "PackerSnapshotRollback",
  "PackerSnapshotDelete",
  "PackerInstall",
  "PackerUpdate",
  "PackerSync",
  "PackerClean",
  "PackerCompile",
  "PackerStatus",
  "PackerProfile",
  "PackerLoad",
}

M.treesitter_cmds = {
  "TSInstall",
  "TSBufEnable",
  "TSBufDisable",
  "TSEnable",
  "TSDisable",
  "TSModuleInfo",
}

M.gitsigns = function()
  -- taken from https://github.com/max397574
  vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
    callback = function()
      vim.fn.system("git rev-parse " .. vim.fn.expand "%:p:h")
      if vim.v.shell_error == 0 then
        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
        vim.schedule(function()
          require("packer").loader "gitsigns.nvim"
        end)
      end

    end,
  })
end

return M
