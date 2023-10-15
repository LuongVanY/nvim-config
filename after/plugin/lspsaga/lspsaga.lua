local status, saga = pcall(require, "lspsaga")
if (not status) then return end
saga.setup({
  ui = {
    border = 'rounded',
    code_action = '󰛨'
  },
  symbol_in_winbar = {
    enable = false
  },
  lightbulb = {
    enable = false
  },
  outline = {
    layout = 'float'
  }
})

