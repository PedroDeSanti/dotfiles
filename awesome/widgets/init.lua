local _M = {}

local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local wibox = require("wibox")

local apps = require("config.apps")
local mod = require("bindings.input.mod")
local mouse = require("bindings.input.mouse")

-- Menu
-- Create a launcher widget and a main menu
_M.launcher = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", apps.manual_cmd },
    { "edit config", apps.editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
 }

_M.mainmenu = awful.menu({
    items = {
        { "awesome", _M.launcher, beautiful.awesome_icon },
        { "open terminal", apps.terminal }
    }
})

_M.launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = _M.mainmenu
})

-- Wibar

-- Keyboard map indicator and switcher
_M.keyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
_M.textclock = wibox.widget.textclock()

-- Create a promptbox for each screen
function _M.create_promptbox() return awful.widget.prompt() end

-- Create an imagebox widget which will contain an icon indicating which layout we're using.
-- We need one layoutbox per screen.
function _M.create_layoutbox(s)
    return awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button {
                modifiers = { },
                button    = mouse.left_click,
                on_press  = function() awful.layout.inc(1) end,
            },
            awful.button {
                modifiers = { },
                button    = mouse.right_click,
                on_press  = function() awful.layout.inc(-1) end,
            },
            awful.button {
                modifiers = { },
                button    = mouse.scroll_up,
                on_press  = function() awful.layout.inc(-1) end,
            },
            awful.button {
                modifiers = { },
                button    = mouse.scroll_down,
                on_press  = function() awful.layout.inc(1) end,
            },
        }
    }
end

-- Create a taglist widget
function _M.create_taglist(s)
    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button {
                modifiers = { },
                button    = mouse.left_click,
                on_press  = function(t) t:view_only() end,
            },
            awful.button {
                modifiers = { mod.super },
                button    = mouse.left_click,
                on_press  = function(t)
                    if client.focus then
                        client.focus:move_to_tag(t)
                    end
                end,
            },
            awful.button {
                modifiers = { },
                button    = mouse.right_click,
                on_press  = awful.tag.viewtoggle,
            },
            awful.button {
                modifiers = { mod.super },
                button    = mouse.right_click,
                on_press  = function(t)
                    if client.focus then
                        client.focus:toggle_tag(t)
                    end
                end,
            },
            awful.button {
                modifiers = { },
                button    = mouse.scroll_up,
                on_press  = function(t) awful.tag.viewprev(t.screen) end,
            },
            awful.button {
                modifiers = { },
                button    = mouse.scroll_down,
                on_press  = function(t) awful.tag.viewnext(t.screen) end,
            },
        }
    }
end

-- Create a tasklist widget
function _M.create_tasklist(s)
    return awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button {
                modifiers = { },
                button    = mouse.left_click,
                on_press  = function (c)
                    c:activate { context = "tasklist", action = "toggle_minimization" }
                end,
            },
            awful.button {
                modifiers = { },
                button    = mouse.right_click,
                on_press  = function() awful.menu.client_list { theme = { width = 250 } } end,
            },
            awful.button {
                modifiers = { },
                button    = mouse.scroll_up,
                on_press  = function() awful.client.focus.byidx(-1) end,
            },
            awful.button {
                modifiers = { },
                button    = mouse.scroll_down,
                on_press  = function() awful.client.focus.byidx(1) end,
            },
        }
    }
end

-- Create the wibox
function _M.create_wibox(s)
    return awful.wibar {
        position = "top",
        screen = s,
        widget = {
            layout = wibox.layout.align.horizontal,
            -- Left widgets
            {
                layout = wibox.layout.fixed.horizontal,
                _M.launcher,
                s.taglist,
                s.promptbox,
            },
            -- Middle widget
            s.tasklist,
            -- Right widgets
            {
                layout = wibox.layout.fixed.horizontal,
                _M.keyboardlayout,
                wibox.widget.systray(),
                _M.textclock,
                s.layoutbox,
            },
        }
    }
end

return _M