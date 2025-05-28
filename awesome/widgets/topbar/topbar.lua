local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local color = require("widgets.topbar.colors")

local _M = {}

-- Spacer
local separator = wibox.widget.textbox("     ")

-- Import widgets
local awesome_logo = require("widgets.topbar.awesome_logo")
local systray_widget = require("widgets.topbar.systray")
local control_buttons = require("widgets.topbar.control_buttons")
local fancy_taglist = require("widgets.topbar.fancy_taglist")

-- Text clock widget
local mytextclock = wibox.widget.textclock(
    '<span color="' .. color.white .. '" font="Ubuntu Nerd Font 12"> %a %b %d, %H:%M </span>', 10)

function _M.create_topbar(s)
    -- Create taglist for this screen
    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
    )

    local tasklist_buttons = gears.table.join(
        awful.button({ }, 1, function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end)
        -- awful.button({ }, 3, function()
        --     awful.menu.client_list({ theme = { width = 250 } })
        -- end)
    )

    -- Create fancy taglist
    local mytaglist = fancy_taglist.new({
        screen   = s,
        taglist  = { buttons = taglist_buttons },
        tasklist = { buttons = tasklist_buttons },
        filter   = awful.widget.taglist.filter.all,
        style    = {
            shape = gears.shape.rounded_rect
        },
    })

    -- Fancy taglist container
    local fancy_taglist_widget = wibox.widget {
        {
            mytaglist,
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

    -- Create the wibar
    local mywibox = awful.wibar({
        position = "top",
        margins = { top = dpi(0), left = dpi(0), right = dpi(0), bottom = 0 },
        screen = s,
        height = dpi(35),
        opacity = 1,
        fg = color.blueish_white,
        bg = "#00000000",
    })

    -- Setup the wibar
    mywibox:setup {
        {
            layout = wibox.layout.stack,
            expand = "none",
            {
                layout = wibox.layout.align.horizontal,
                {
                    -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
                    separator,
                    awesome_logo,
                    separator,
                    fancy_taglist_widget,
                    separator,
                },
                nil,
                {
                    -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    systray_widget,
                    separator,
                    control_buttons,
                    separator,
                },
            },
            {
                mytextclock,
                valign = "center",
                halign = "center",
                layout = wibox.container.place,
            }
        },
        widget = wibox.container.background,
        bg = color.background_dark,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 0)
        end,
    }

    return mywibox
end

return _M
