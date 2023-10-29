local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({
  ensure_installed = { "tsserver", "css" },
  automatic_installation = true,
  handlers = {
    function(config) require("mason-nvim-dap").default_setup(config) end,
  },
})

lspconfig.setup {
  automatic_installation = true
}
