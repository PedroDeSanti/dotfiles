local _M = {}

local awful = require("awful")

-- Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
_M.layouts = {
    awful.layout.suit.tile, --santi
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    awful.layout.suit.floating,
}

_M.tags = {'1', '2', '3', '4', '5', '6', '7', '8', '9'}

return _M