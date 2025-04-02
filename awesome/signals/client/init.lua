local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")

-- Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button {
            modifiers = { },
            button    = 1,
            on_press  = function()
                c:activate { context = "titlebar", action = "mouse_move" }
            end
        },
        awful.button {
            modifiers = { },
            button    = 3,
            on_press  = function()
                c:activate { context = "titlebar", action = "mouse_resize" }
            end
        },
    }

    awful.titlebar(c).widget = {
        -- Left
        {
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        -- Middle
        {
            -- Title
            {
                halign = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        -- Right
        {
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
