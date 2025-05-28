local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local color = require("widgets.topbar.colors")
local dpi = beautiful.xresources.apply_dpi

-- Import control center
local control_center = require("widgets.control_center.main")

local separator = wibox.widget.textbox("   ")

local create_button = function(icon)
    -- Imagebox for icon
    local icon_image = wibox.widget {
        widget = wibox.widget.imagebox,
        image = gears.filesystem.get_configuration_dir() .. "widgets/topbar/icons/" .. icon .. ".png",
        resize = true,
        opacity = 1,
    }

    -- Main button
    local created_button = wibox.widget {
        {
            icon_image,
            left   = dpi(6),
            right  = dpi(6),
            top    = dpi(6),
            bottom = dpi(6),
            widget = wibox.container.margin
        },
        bg = color.background_lighter,
        shape = gears.shape.rounded_rect,
        widget = wibox.container.background,
    }
    return created_button
end

local screenshot = create_button('screenshot')
local settings = create_button('settings')
local music = create_button('music-icon')

-- Add basic functionality
screenshot:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        -- Basic screenshot functionality
        awful.spawn.with_shell("scrot ~/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).png")
    end
end)

settings:connect_signal("button::release", function()
    -- Toggle control center
    control_center:toggle()
end)

music:connect_signal("button::release", function()
    -- You can add music player functionality here
    awful.spawn("playerctl play-pause")
end)

-- Main Widget
local control_buttons = wibox.widget {
    {
        {
            separator,
            music,
            separator,
            settings,
            separator,
            screenshot,
            separator,
            layout = wibox.layout.fixed.horizontal,
        },
        widget = wibox.container.background,
        shape  = gears.shape.rounded_rect,
        bg     = color.background_lighter
    },
    left   = dpi(3),
    right  = dpi(3),
    top    = dpi(3),
    bottom = dpi(3),
    widget = wibox.container.margin
}

return control_buttons
