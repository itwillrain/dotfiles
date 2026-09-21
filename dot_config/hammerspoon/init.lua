local alert = require("hs.alert")
require("hs.ipc")
hs.autoLaunch(true)

local catppuccin = {
  base = { red = 30 / 255, green = 30 / 255, blue = 46 / 255 },
  mauve = { red = 203 / 255, green = 166 / 255, blue = 247 / 255 },
  text = { red = 205 / 255, green = 214 / 255, blue = 244 / 255 },
}

local style = {
  fillColor = { red = catppuccin.base.red, green = catppuccin.base.green, blue = catppuccin.base.blue, alpha = 0.92 },
  strokeColor = { red = catppuccin.mauve.red, green = catppuccin.mauve.green, blue = catppuccin.mauve.blue, alpha = 0.8 },
  strokeWidth = 3,
  radius = 28,
  textColor = { red = catppuccin.text.red, green = catppuccin.text.green, blue = catppuccin.text.blue, alpha = 1 },
  textFont = "Helvetica-Bold",
  textSize = 112,
  padding = 28,
  atScreenEdge = 0,
  fadeInDuration = 0,
  fadeOutDuration = 0,
}

function show_workspace(workspace, screen_index)
  alert.closeAll(0)

  local index = tonumber(screen_index)
  local screen = index and hs.screen.allScreens()[index] or nil
  alert.show(tostring(workspace), style, screen, 0.8)
end

local cli_root = os.getenv("HOME") .. "/.local"
hs.ipc.cliInstall(cli_root, true)
