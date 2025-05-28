--Standard Modules
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

--Custom Modules
local bling = require("modules.bling")
local color = require("widgets.control_center.color")

-----------------------------------
--Music Player Widget--------------
-----------------------------------

local art = wibox.widget {
  image = os.getenv("HOME") .. "/.config/awesome/widgets/control_center/assets/music.svg",
  resize = true,
  forced_height = dpi(45),
  forced_width = dpi(80),
  widget = wibox.widget.imagebox,
  valign = "left",
}

local name_widget = wibox.widget {
  markup = 'No players',
  align = 'left',
  valign = 'top',
  widget = wibox.widget.textbox,
  font = "CaskaydiaCove Nerd Font 14",
  forced_width = dpi(200),
}

local title_widget = wibox.widget {
  markup = '<span color="' ..
      color.blueish_white .. '" font="Ubuntu Nerd Font bold 12">' .. "Nothing Playing" .. '</span>',
  align = 'left',
  valign = 'top',
  widget = wibox.widget.textbox,
  font = "CaskaydiaCove Nerd Font 12",
  forced_width = dpi(210),
  forced_height = dpi(25),
}

local artist_widget = wibox.widget {
  markup = '<span color="' ..
      color.white .. '" font="Ubuntu Nerd Font 11">' .. "Unknown Artist" .. '</span>',
  align = 'left',
  valign = 'bottom',
  widget = wibox.widget.textbox,
  font = "CaskaydiaCove Nerd Font 10",
  forced_width = dpi(210),
  forced_height = dpi(20),
}

-- Get Song Info using bling playerctl
local playerctl = bling.signal.playerctl.lib()

--Play pause button
local button = wibox.widget {
  image = os.getenv("HOME") .. "/.config/awesome/widgets/control_center/assets/pause.png",
  resize = true,
  forced_height = dpi(25),
  forced_width = dpi(25),
  widget = wibox.widget.imagebox,
  valign = "center",
}

local is_playing = false

playerctl:connect_signal("metadata",
  function(_, title, artist, album_path, album, new, player_name)
    -- Set art widget
    if album_path and album_path ~= "" then
      art:set_image(gears.surface.load_uncached(album_path))
    end

    -- Set player name, title and artist widgets
    name_widget:set_markup_silently(player_name or "No players")
    title_widget:set_markup_silently('<span color="' ..
      color.blueish_white .. '" font="Ubuntu Nerd Font 8 bold">' .. (title or "Nothing Playing") .. '</span>')
    artist_widget:set_markup_silently('<span color="' ..
      color.white .. '" font="Ubuntu Nerd Font 11">' .. (artist or "Unknown Artist") .. '</span>')
  end)

playerctl:connect_signal("position",
  function(_, interval_sec, length_sec, player_name)
    -- Only update if we're actually playing (interval changes)
    -- This signal can fire even when paused, so we need to be more careful
  end)

-- Handle playback status changes
playerctl:connect_signal("playback_status",
  function(_, playing, player_name)
    is_playing = playing
    if is_playing then
      button:set_image(os.getenv("HOME") .. "/.config/awesome/widgets/control_center/assets/pause.png")
    else
      button:set_image(os.getenv("HOME") .. "/.config/awesome/widgets/control_center/assets/play.png")
    end
  end)

--Play pause button functionality
button:buttons(gears.table.join(
  awful.button({}, 1, function()
    playerctl:play_pause()
    is_playing = not is_playing
    if is_playing then
      -- When playing, show pause button
      button:set_image(os.getenv("HOME") .. "/.config/awesome/widgets/control_center/assets/pause.png")
    else
      -- When paused, show play button
      button:set_image(os.getenv("HOME") .. "/.config/awesome/widgets/control_center/assets/play.png")
    end
  end)
))

---------------------------------------
--Main Widget--------------------------
---------------------------------------

local music_player = wibox.widget {
  {
    {
      {
        {
          {
            art,
            widget = wibox.container.margin,
            top = dpi(6),
            bottom = dpi(6),
            left = dpi(10),
            right = dpi(6),
          },
          {
            {
              {
                title_widget,
                widget = wibox.container.margin,
                top = dpi(1),
                bottom = 0,
                left = 0,
                right = 0
              },
              artist_widget,
              layout = wibox.layout.fixed.vertical
            },
            widget = wibox.container.margin,
            top = dpi(4),
            bottom = dpi(6),
            left = dpi(15),
            right = 0
          },
          {
            button,
            widget = wibox.container.margin,
            top = dpi(2),
            bottom = dpi(2),
            right = 0,
            left = dpi(35),
          },
          layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.margin,
        top = dpi(6),
        bottom = dpi(6),
        left = dpi(2),
        right = 0,
      },
      layout = wibox.layout.fixed.horizontal
    },
    widget = wibox.container.margin,
    top = dpi(3),
    bottom = dpi(3),
    right = dpi(3),
    left = dpi(3),
  },
  widget = wibox.container.background,
  bg = color.background_lighter,
  forced_width = dpi(410),
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 10)
  end,
}

return music_player
