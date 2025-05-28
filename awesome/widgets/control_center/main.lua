--Standard Modules
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--Custom Modules
local color = require("widgets.control_center.color")

--Widgets
local Separator = wibox.widget.textbox("    ")
Separator.forced_height = dpi(11)

--Control Center Items
local profile = require("widgets.control_center.header.header")
local buttons = require("widgets.control_center.header.button")

local left_buttons = require("widgets.control_center.buttons.left")
local right_buttons = require("widgets.control_center.buttons.right")

local slider = require("widgets.control_center.sliders.sliders")

local music_player = require("widgets.control_center.music.music")

--Main Wibox
local control = awful.popup {
	screen = awful.screen.focused(),
	widget = wibox.container.background,
	ontop = true,
	bg = "#00000000",
	visible = false,
	placement = function(c)
		awful.placement.top_right(c,
			{ margins = { top = dpi(43), bottom = dpi(8), left = dpi(8), right = dpi(8) } })
	end,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 0)
	end,
	opacity = 1
}

control:setup {
	{
		{
			{
				profile,
				Separator,
				buttons,
				layout = wibox.layout.fixed.horizontal
			},
			widget = wibox.container.margin,
			top    = dpi(11),
			bottom = dpi(11),
			left   = dpi(11),
			right  = dpi(11)
		},
		{
			{
				left_buttons,
				Separator,
				{
					right_buttons.silent,
					Separator,
					right_buttons.nightmode,
					layout = wibox.layout.fixed.vertical
				},
				layout = wibox.layout.fixed.horizontal
			},
			widget = wibox.container.margin,
			top = 0,
			bottom = dpi(11),
			right = dpi(11),
			left = dpi(11),
		},
		{
			slider.brightness,
			widget = wibox.container.margin,
			top = 0,
			bottom = dpi(11),
			right = dpi(11),
			left = dpi(11),
		},
		{
			slider.volume,
			widget = wibox.container.margin,
			top = 0,
			bottom = dpi(11),
			right = dpi(11),
			left = dpi(11),
		},
		{
			music_player,
			widget = wibox.container.margin,
			top = 0,
			bottom = dpi(11),
			right = dpi(11),
			left = dpi(11),
		},
		layout = wibox.layout.fixed.vertical
	},
	widget = wibox.container.background,
	bg = color.background_dark,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 10)
	end,
}

-- Signal to hide control center
awesome.connect_signal("widget::control", function()
	control.visible = false
end)

-- Function to toggle control center visibility
function control:toggle()
	self.visible = not self.visible
end

-- Function to show control center
function control:show()
	self.visible = true
end

-- Function to hide control center
function control:hide()
	self.visible = false
end

return control
