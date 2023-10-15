local notify = require("notify")
notify.setup({
  fps = 120,
  render = "wrapped-compact",
  timeout = 500,
  background_colour = "#000000"
})
vim.notify = notify
