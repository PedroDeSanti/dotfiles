local awful = require("awful")

local mod = require("bindings.input.mod")
local mouse = require("bindings.input.mouse")

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button {
            modifiers = { },
            button    = mouse.left_click,
            on_press  = function(c) c:activate { context = "mouse_click" } end,
        },
        awful.button {
            modifiers = { mod.super },
            button    = mouse.left_click,
            on_press  = function(c) c:activate { context = "mouse_click", action = "mouse_move" } end,
        },
        awful.button {
            modifiers = { mod.super },
            button    = mouse.right_click,
            on_press  = function(c) c:activate { context = "mouse_click", action = "mouse_resize" } end,
        },
    })
end)