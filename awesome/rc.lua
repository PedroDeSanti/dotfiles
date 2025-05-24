-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
local theme_dir = gears.filesystem.get_configuration_dir() .. "theme/"
beautiful.init(theme_dir .. "theme.lua")

-- Gaps
beautiful.useless_gap = 8

require("modules")
require("bindings")
require("rules")
require("signals")

awful.spawn.with_shell('kitty')
awful.spawn.with_shell('picom')
awful.spawn.with_shell('touchegg')

--- ░█▀▀░█▀█░█▀▄░█▀▄░█▀█░█▀▀░█▀▀
--- ░█░█░█▀█░█▀▄░█▀▄░█▀█░█░█░█▀▀
--- ░▀▀▀░▀░▀░▀░▀░▀▀░░▀░▀░▀▀▀░▀▀▀

--- Enable for lower memory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		collectgarbage("collect")
	end,
})
