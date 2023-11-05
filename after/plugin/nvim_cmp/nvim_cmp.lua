local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lspkind = require 'lspkind'
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local luasnip = require("luasnip")

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  -- sorting = {
  --   priority_weight = 2,
  --   comparators = {
  --     compare.offset,
  --     compare.exact,
  --     compare.score,
  --     compare.kind,
  --     compare.sort_text,
  --     compare.length,
  --     compare.order,
  --   },
  -- },

  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment") 
      and not context.in_syntax_group("Comment")
    end
  end,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable() then
        luasnip.jump(1)
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 's'}),
    ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 's'}),
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
    ['<CR>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
    }),
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = "luasnip" }, -- snippets
    { name = "nvim_lsp" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end
      }
    }, -- text within current buffer
    { name = "path" }, -- file system paths
    option = {
      trailing_slash = true
    }
  }),
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 250,
      ellipsis_char = '...',
      -- mode = 'symbol',
      before = function(entry, vim_item)
        vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
        if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
          vim_item.menu = entry.completion_item.detail
        else
          vim_item.menu = ({
            -- nvim_lsp = "[LSP]",
            -- luasnip = "[Snippet]",
            -- buffer = "[Buffer]",
            -- path = "[Path]",
          })[entry.source.name]
        end

        return vim_item
      end
    })
  }
})

vim.cmd [[
set completeopt=menuone,noselect
highlight! default link CmpItemKind CmpItemMenuDefault
]]


