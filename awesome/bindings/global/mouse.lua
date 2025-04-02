local awful = require("awful")
local widgets = require("widgets")
local mouse = require("bindings.input.mouse")

awful.mouse.append_global_mousebindings({
    awful.button{
        modifiers = { },
        button    = mouse.right_click,
        on_press  = function() widgets.mainmenu:toggle() end
    },
    -- awful.button{
    --     modifiers = { },
    --     button    = mouse.scroll_up,
    --     on_press  = awful.tag.viewprev
    -- },
    -- awful.button{
    --     modifiers = { },
    --     button    = mouse.scroll_down,
    --     on_press  = awful.tag.viewnext
    -- },
})