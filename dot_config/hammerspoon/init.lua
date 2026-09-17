local alert = require("hs.alert")
require("hs.ipc")
hs.autoLaunch(true)

local style = {
  fillColor = { white = 0, alpha = 0.78 },
  strokeColor = { white = 0, alpha = 0 },
  strokeWidth = 0,
  radius = 28,
  textColor = { white = 1, alpha = 1 },
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
