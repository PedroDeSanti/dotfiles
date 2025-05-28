local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()

local _M = {
    terminal = os.getenv("TERMINAL") or "kitty",
    editor   = os.getenv("EDITOR")   or "nano",
    app_launcher    = "rofi -no-lazy-grab -show drun   -modi drun   -theme " .. config_dir .. "config/rofi.rasi",
    window_switcher = "rofi -no-lazy-grab -show window -modi window -theme " .. config_dir .. "config/rofi.rasi",
    screenshot = "flameshot gui",
    volume = {
        up   = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+",
        down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
        mute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
    },
    brightness = {
        up   = "brightnessctl set +10%",
        down = "brightnessctl set 10%-",
    },
    media = {
        play_pause = "playerctl play-pause",
        next       = "playerctl next",
        previous   = "playerctl previous",
    },
}

_M.editor_cmd = _M.terminal .. " -e " .. _M.editor
_M.manual_cmd = _M.terminal .. "-e man awesome"

return _M
