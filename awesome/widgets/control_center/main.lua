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
	opacity = 1,
	hide_on_right_click = false,
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
	-- No buttons here - we'll handle it differently
}

-- Signal to hide control center
awesome.connect_signal("widget::control", function()
	control.visible = false
end)

-- Robust auto-close using client-focused events and key bindings
local function setup_auto_close()
	-- Method 1: Close when clicking on any client (application window)
	client.connect_signal("button::press", function(c, x, y, button, mods, find_widgets_result)
		if control.visible then
			control.visible = false
		end
	end)
	
	-- Method 2: Close when any client gets focus
	client.connect_signal("focus", function(c)
		if control.visible then
			control.visible = false
		end
	end)
	
	-- Method 3: Close when user presses Escape (already implemented in key bindings)
	-- Method 4: Close when switching workspace/tag
	tag.connect_signal("property::selected", function()
		if control.visible then
			control.visible = false
		end
	end)

	-- Method 5: Close when any new window/application is launched
	client.connect_signal("manage", function()
		if control.visible then
			control.visible = false
		end
	end)
	
	-- Method 6: Close when desktop/root window is clicked
	-- Using a more compatible approach
	awesome.connect_signal("startup", function()
		root.buttons(gears.table.join(
			root.buttons(),
			awful.button({ }, 1, function()
				if control.visible then
					control.visible = false
				end
			end)
		))
	end)
end

-- Initialize auto-close functionality
setup_auto_close()

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
