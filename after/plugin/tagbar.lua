local Remap = require("yluong.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<S-t>", "<Cmd>TagbarToggle<CR>", silent)
