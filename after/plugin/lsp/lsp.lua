local lsp = require("lsp-zero").preset({})
local Remap = require("yluong.keymap")
local inoremap = Remap.inoremap
local nnoremap = Remap.nnoremap

local protocol = require('vim.lsp.protocol')
local status, nvim_lsp = pcall(require, "lspconfig")
-- local navbuddy = require("nvim-navbuddy")
local navic = require("nvim-navic")
require("nvim-navbuddy").setup()
local navbuddy = require("nvim-navbuddy")


local on_attach = function(client, bufnr)
  if (client.name == "tsserver") or (client.name =="volar" ) or (client.name == "tailwindcss") then
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
    -- client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = false
  else
    client.server_capabilities.documentFormattingProvider = true -- 0.8 and later
    client.server_capabilities.documentRangeFormattingProvider = true
  end


  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    navbuddy.attach(client, bufnr)
  end
end


-- local on_attach = function(client, bufnr)
--   navbuddy.attach(client, bufnr)
-- end

lsp.on_attach(function(client, bufnr)
  -- lsp.default_keymaps({ buffer = bufnr })
  local opts = { buffer = bufnr, silent = true }
  nnoremap("<leader>.", function() vim.lsp.buf.code_action() end, opts)
  nnoremap("<leader>rn", function() vim.lsp.buf.rename() end, opts)
  nnoremap("<leader>fi", function() vim.lsp.buf.implementation() end, opts)
  nnoremap("<leader>fr", function() vim.lsp.buf.references() end, opts)
  nnoremap("<leader>ff", function() vim.lsp.buf.definition() end, opts)
  nnoremap("<leader>fF", function() vim.lsp.buf.declaration() end, opts)
  nnoremap("K", function() vim.lsp.buf.hover() end, opts)
  -- inoremap("<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  inoremap("<C-j>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem = {
--   snippetSupport = true,
--   preselectSupport = true,
--   insertReplaceSupport = true,
--   labelDetailsSupport = true,
--   deprecatedSupport = true,
--   commitCharactersSupport = true,
-- }

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
  settings = {
    completions = {
      completeFunctionCalls = true
    }
  },
}

nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
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

