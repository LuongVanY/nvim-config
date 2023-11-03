local Remap = require("yluong.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.vnoremap

local opts = { silent = true }
nnoremap('<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
nnoremap('gl', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
nnoremap('K', '<Cmd>Lspsaga hover_doc<CR>', opts)
nnoremap('gd', '<Cmd>Lspsaga finder<CR>', opts)
nnoremap('gt', '<Cmd>Lspsaga goto_type_definition<CR>', opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
inoremap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
nnoremap('gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
nnoremap('gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set({'n','t'}, '<C-i>', '<cmd>Lspsaga term_toggle<CR>')

-- code action
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
-- require("lspsaga.symbol.winbar").get_bar()
