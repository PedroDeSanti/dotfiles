local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local color = require("widgets.topbar.colors")

-- Main Logo
local awesome_logo = wibox.widget {
    {
        {
            widget = wibox.widget.imagebox,
            image = gears.filesystem.get_configuration_dir() .. "widgets/topbar/icons/awesome-config-logo.jpg",
            resize = true,
            opacity = 1,
        },
        left   = dpi(7),
        right  = dpi(7),
        top    = dpi(7),
        bottom = dpi(7),
        widget = wibox.container.margin
    },
    bg = color.background_dark,
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background,
}

-- Optional: Add click functionality (you can customize this later)
awesome_logo:connect_signal("button::release", function()
    -- You can add functionality here, like opening a menu or dashboard
end)

return awesome_logo
