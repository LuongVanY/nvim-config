local nnoremap = require("yluong.keymap").nnoremap
local telescope_builtin = require("telescope.builtin")
local silent = {silent = true}
require("telescope").load_extension("notify")
nnoremap("<leader>p", telescope_builtin.find_files, silent)
nnoremap("<leader>x", telescope_builtin.live_grep, silent)
nnoremap("<leader>b", telescope_builtin.buffers, silent)
