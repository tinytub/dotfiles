local M = {}

local lspconfig = require 'lspconfig'
M.setup_lsp = function(attach, capabilities)
   local lsp_installer = require "nvim-lsp-installer"

   lsp_installer.on_server_ready(function(server)
      local opts = {
         on_attach = attach,
         capabilities = capabilities
      }

      if server.name == "gopls" then
        opts.root_dir = function(fname)
            return lspconfig.util.root_pattern("go.mod", ".git")(fname) or
              lspconfig.util.path.dirname(fname)
        end

        opts.settings = {
             gopls = {
                 analyses = {
                     fillstruct = false, -- 关闭自动填充 struct. 默认打开
                     unusedparams = true
                 },
                 staticcheck = true
             }
        }
        opts.init_options = {
            usePlaceholders = false, -- 填充补全后的 functions param. 默认打开
            completeUnimported = true,
            --gofumpt = false,
            --hoverKind = "SingleLine",
            --hoverKind = "Structured",
            staticcheck = false,
            deepCompletion = false,
            --allowModfileModifications=true
        }
      end
      if server.name == 'sumneko_lua' then
        opts.init_options = { documentFormatting = true, codeAction = false }
        opts.filetypes = { "lua" }
        opts.settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    --
                    enable = true,
                    globals = {"vim","packer_plugins"}
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
                    preloadFileSize = 100000,
                    maxPreload = 10000
                }
            }
        }
      end
      --if server.name == 'efm' then
      --    opts.filetypes = { "lua" }
      --    opts.settings = {
      --        Lua = {
      --        rootMarkers = { ".git/" },
      --        languages = {
      --          lua = {
      --             {
      --              formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=80",
      --              formatStdin = true,
      --            },
      --            {
      --              formatCommand = "luafmt --indent-count 2 --line-width 120 --stdin",
      --              formatStdin = true,
      --            }
      --          }
      --        },
      --    }
      --  }
      --end
      if server.name == 'jsonls' then
        opts.commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
                end
            }
        }
      end
      server:setup(opts)
      vim.cmd [[ do User LspAttachBuffers ]]
   end
   )
end

return M