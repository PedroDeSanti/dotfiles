local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local menubar = require("menubar")

local apps = require("config.apps")
local mod = require("bindings.input.mod")
local widgets = require("widgets")

local gmath = require("gears.math")

menubar.utils.terminal = apps.terminal

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { mod.super },
        key         = "s",
        description = "show help",
        group       = "awesome",
        on_press    = hotkeys_popup.show_help,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "w",
        description = "show main menu",
        group       = "awesome",
        on_press    = function () widgets.mainmenu:show() end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = "r",
        description = "reload awesome",
        group       = "awesome",
        on_press    = awesome.restart,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = "q",
        description = "quit awesome",
        group       = "awesome",
        on_press    = awesome.quit,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "x",
        description = "lua execute prompt",
        group       = "awesome",
        on_press    = function ()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().promptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "t",
        description = "open a terminal",
        group       = "launcher",
        on_press    = function () awful.spawn(apps.terminal) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "r",
        description = "open rofi launcher",
        group       = "launcher",
        on_press    = function () awful.spawn.with_shell(apps.app_launcher) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = "r",
        description = "open rofi window switcher",
        group       = "launcher",
        on_press    = function () awful.spawn.with_shell(apps.window_switcher) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "p",
        description = "show the menubar",
        group       = "launcher",
        on_press    = function() menubar.show() end,
    },
})


-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { mod.super },
        key         = "Left",
        description = "view previous",
        group       = "tag",
        on_press    = awful.tag.viewprev,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "Right",
        description = "view next",
        group       = "tag",
        on_press    = awful.tag.viewnext,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "Tab",
        description = "go back",
        group       = "tag",
        on_press    = function ()
            awful.tag.history.restore()
            if client.focus then
                client.focus:raise()
            end
        end
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = "Left",
        description = "move focused client to previous tag",
        group       = "tag",
        on_press    = function ()
            if client.focus then
                local t = client.focus.screen.selected_tag
                local tags = client.focus.screen.tags
                local idx = t.index
                local newtag = tags[gmath.cycle(#tags, idx - 1)]
                client.focus:move_to_tag(newtag)
                -- newtag:view_only()
                awful.tag.viewprev()
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = "Right",
        description = "move focused client to next tag",
        group       = "tag",
        on_press    = function ()
            if client.focus then
                local t = client.focus.screen.selected_tag
                local tags = client.focus.screen.tags
                local idx = t.index
                local newtag = tags[gmath.cycle(#tags, idx + 1)]
                client.focus:move_to_tag(newtag)
                -- newtag:view_only()
                awful.tag.viewnext()
            end
        end,
    },
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { mod.super },
        key         = "j",
        description = "focus next client",
        group       = "client",
        on_press    = function () awful.client.focus.byidx(1) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "k",
        description = "focus previous client",
        group       = "client",
        on_press    = function () awful.client.focus.byidx(-1) end,
    },
    awful.key {
        modifiers   = { mod.alt },
        key         = "Tab",
        description = "go back",
        group       = "client",
        on_press    = function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = "j",
        description = "focus next screen",
        group       = "screen",
        on_press    = function () awful.screen.focus_relative(1) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = "k",
        description = "focus previous screen",
        group       = "screen",
        on_press    = function () awful.screen.focus_relative(-1) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = "n",
        description = "restore minimized",
        group       = "client",
        on_press    = function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
    },
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = "j",
        description = "swap with next client by index",
        group       = "client",
        on_press    = function () awful.client.swap.byidx(1) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = "k",
        description = "swap with previous client by index",
        group       = "client",
        on_press    = function () awful.client.swap.byidx(-1) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "u",
        description = "jump to urgent client",
        group       = "client",
        on_press    = awful.client.urgent.jumpto,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "l",
        description = "increase master width factor",
        group       = "layout",
        on_press    = function () awful.tag.incmwfact(0.05) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "h",
        description = "decrease master width factor",
        group       = "layout",
        on_press    = function () awful.tag.incmwfact(-0.05) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = "h",
        description = "increase the number of master clients",
        group       = "layout",
        on_press    = function () awful.tag.incnmaster(1, nil, true) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = "l",
        description = "decrease the number of master clients",
        group       = "layout",
        on_press    = function () awful.tag.incnmaster(-1, nil, true) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = "h",
        description = "increase the number of columns",
        group       = "layout",
        on_press    = function () awful.tag.incncol(1, nil, true) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = "l",
        description = "decrease the number of columns",
        group       = "layout",
        on_press    = function () awful.tag.incncol(-1, nil, true) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = "space",
        description = "select next",
        group       = "layout",
        on_press    = function () awful.layout.inc(1) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = "space",
        description = "select previous",
        group       = "layout",
        on_press    = function () awful.layout.inc(-1) end,
    },
})


awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { mod.super },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { mod.super, mod.shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only() --santi
                end
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl, mod.shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    },
})
