local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local vars = require("config.vars")
local widgets = require("widgets")

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = beautiful.wallpaper,
                upscale   = true,
                downscale = true,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)

-- Wibar
screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag(vars.tags, s, awful.layout.layouts[1])
    s.promptbox = widgets.create_promptbox()
    s.layoutbox = widgets.create_layoutbox(s)
    s.taglist   = widgets.create_taglist(s)
    s.tasklist  = widgets.create_tasklist(s)

    -- Use the new fancy topbar instead of the old wibox
    s.wibox     = widgets.create_topbar(s)
    -- If you want to go back to the original, uncomment the line below and comment the one above
    -- s.wibox     = widgets.create_wibox(s)
end)
