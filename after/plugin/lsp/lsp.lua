local status, nvim_lsp = pcall(require, "lspconfig")
local navbuddy = require("nvim-navbuddy")

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
  navbuddy.attach(client, bufnr)
end


nvim_lsp.vtsls.setup {
  on_attach = on_attach,
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  single_file_support = true,
  handlers = {
    source_definition = function(err, locations) end,
    file_references = function(err, locations) end,
    code_action = function(err, actions) end,
  },
  -- automatically trigger renaming of extracted symbol
  refactor_auto_rename = true,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      }
    },
  }
}

nvim_lsp.denols.setup {
  on_attach = on_attach,
  cmd = { "deno", "lsp" },
  cmd_env = {
    NO_COLOR = true
},
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", 'markdown', },
  settings = {
    deno = {
      enable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://crux.land"] = true,
            ["https://deno.land"] = true,
            ["https://x.nest.land"] = true
          }
        }
      }
    }
  },
}

nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach =  on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "\u{ea71}" },
    severity_sort = true,
  }
)

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

