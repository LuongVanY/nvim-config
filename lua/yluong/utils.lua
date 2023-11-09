
local currentOS = vim.loop.os_uname().sysname
local osHome = currentOS == "Darwin" and  os.getenv("HOME") or os.getenv("UserProfile")

local function GetOsPath(x)
  local path = ''
  if currentOS == "Darwin" then
    path = osHome .. "/.config/nvim/"
  elseif currentOS == "Linux" then
  elseif currentOS == "Windows_NT" then
    path = osHome .. "\\AppData\\Local\\nvim\\"
  else
    error("Unknown currentOS")
  end
  path = path .. x
  return path
end

return GetOsPath

