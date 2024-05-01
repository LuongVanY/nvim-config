local Remap = require("yluong.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.vnoremap

local opts = { silent = true }
nnoremap('<leader>ff', '<Cmd>:Farf<CR>', opts)
inoremap('<leader>ff', '<Cmd>:Farf<CR>', opts)
nnoremap('<leader>fr', '<Cmd>:Farr<CR>', opts)
inoremap('<leader>fr', '<Cmd>:Farr<CR>', opts)
