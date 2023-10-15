local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup({
  performance = {
    debounce = 0,
    throttle = 0,
    confirm_resolve_timeout = 0,
  },
  preselect = "Item",
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  sources = { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "nvim_lua" } },
  view = {},
  window = {
    completion = {
      border = "rounded",
    },
    documentation = {
      border = "rounded",
    },
  },
})

