local GetOsPath = require("yluong.utils")
local options = {
  autoindent = true,
  smartindent = true,
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  showtabline = 2,
  showmatch = true,

  number = true,
  relativenumber = true,
  numberwidth = 4,
  incsearch = true,
  hlsearch = false,
  ignorecase = true,
  smartcase = true,

  splitbelow = true,
  splitright = true,

  termguicolors = true,
  hidden = true,
  signcolumn = "yes",
  showmode = false,
  errorbells = false,
  wrap = false,
  cursorline = true,
  fileencoding = "utf-8",

  backup = false,
  writebackup = false,
  swapfile = false,
  undodir = GetOsPath("undodir"),
  undofile = true,

  -- colorcolumn = "80",
  updatetime = 20,
  scrolloff = 15,
  mouse = "a",
  guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",

  -- title = true,
  -- titlestring = "%t - Wvim",
  titlestring = "Neovim - %t",
  guifont = "MesloLGS NF:h18",
  -- clipboard = "unnamedplus",
  lazyredraw = true,
  regexpengine = 1,
}

-- vim.opt.nrformats:append("alpha") -- increment letters
vim.opt.shortmess:append("IsF")

-- vim.o.shortmess = "filnxstToOFS"

for option, value in pairs(options) do
  print(value, option)
  vim.opt[option] = value
end
