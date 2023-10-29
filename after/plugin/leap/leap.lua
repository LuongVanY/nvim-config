local status, leap = pcall(require, "leap")
if (not status) then return end


leap.setup({
  enabled = true,
})

leap.add_default_mappings(true)
