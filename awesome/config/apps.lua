local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()

local _M = {
    terminal = os.getenv("TERMINAL") or "kitty",
    editor   = os.getenv("EDITOR")   or "nano",
    app_launcher = "rofi -no-lazy-grab -show drun -modi drun -theme " .. config_dir .. "config/rofi.rasi",
}

_M.editor_cmd = _M.terminal .. " -e " .. _M.editor
_M.manual_cmd = _M.terminal .. "-e man awesome"

return _M
