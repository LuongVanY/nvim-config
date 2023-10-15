local Remap = require("yluong.keymap")
local nnoremap = Remap.nnoremap

local silent = { silent = true }
nnoremap("<leader><tab>", "<Cmd>NvimTreeToggle<CR>", silent)
nnoremap("<leader>n", "<Cmd>tabnew<CR><Cmd>NvimTreeToggle<CR>", silent)
nnoremap("<leader>f<tab>", "<Cmd>NvimTreeFindFileToggle<CR>", silent)
nnoremap("<leader>z", "<Cmd>NvimTreeCollapse<CR>", silent)
