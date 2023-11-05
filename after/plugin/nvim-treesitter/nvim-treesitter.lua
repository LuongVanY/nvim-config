local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "typescript",
    "json",
    "css",
    "html",
    "lua"
  },
  autotag = {
    enable = false,
  },
  context_commentstring = {
    enable         = true,
    enable_autocmd = false,
  },
  modules = {
  },
  sync_install = false,
  ignore_install = {
  },
  auto_install = true,
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
