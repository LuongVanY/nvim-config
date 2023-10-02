local lsp = require("lsp-zero").preset({})
local Remap = require("yluong.keymap")
local inoremap = Remap.inoremap
local nnoremap = Remap.nnoremap

local protocol = require('vim.lsp.protocol')
local status, nvim_lsp = pcall(require, "lspconfig")
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

lsp.format_mapping("<leader>m", {
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ["rust_analyzer"] = { "rust" },
    ["gopls"] = { "go" },
    ["pylsp"] = { "python" },
    ["null-ls"] = {
      "lua",
      "c",
      "cpp",
      "json",
      "javascript",
      "typescript",
      "typescriptreact",
      "markdown",
      "css",
      "sass",
      "scss",
      "txt",
      "text",
    },
  },
})

lsp.setup()

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.flow.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities
}

nvim_lsp.sourcekit.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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

nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.astro.setup {
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

require("mason-nvim-dap").setup({
  ensure_installed = { "python", "cpp" },
  automatic_installation = true,
  handlers = {
    function(config) require("mason-nvim-dap").default_setup(config) end,
  },
})

