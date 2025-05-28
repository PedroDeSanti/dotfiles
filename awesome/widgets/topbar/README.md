# Topbar Widget

This topbar widget is inspired by and adapted from the Awful-DOTS configuration. It provides a modern, feature-rich topbar for AwesomeWM.

## Features

- **Awesome Logo**: Clickable logo that can be configured to open menus or dashboards
- **Fancy Taglist**: Shows tags with their associated application icons
- **System Tray**: Collapsible system tray with toggle button
- **Control Buttons**: Quick access buttons for screenshot, settings, and music control
- **Centered Clock**: Displays current date and time in the center of the topbar
- **Modern Design**: Uses rounded corners and a dark theme

## Components

- `topbar.lua` - Main topbar widget that combines all components
- `colors.lua` - Color scheme definition
- `awesome_logo.lua` - Awesome logo widget
- `systray.lua` - System tray with toggle functionality
- `control_buttons.lua` - Control buttons (screenshot, settings, music)
- `fancy_taglist.lua` - Enhanced taglist with client icons
- `icons/` - Icon files used by the topbar

## Customization

### Colors
Edit `colors.lua` to change the color scheme:
```lua
local color = {
  background_dark      = "#1a1b26",  -- Main background
  background_lighter   = "#24283b",  -- Widget backgrounds
  white                = "#a9b1d6",  -- Text color
  -- ... other colors
}
```

### Control Buttons
Edit `control_buttons.lua` to modify button functionality:
- Screenshot button: Currently saves to ~/Pictures/
- Settings button: Opens gnome-control-center
- Music button: Uses playerctl for play/pause

### Switching Back
To use the original topbar, edit `signals/screen/init.lua` and uncomment the original line:
```lua
-- s.wibox = widgets.create_topbar(s)  -- New fancy topbar
s.wibox = widgets.create_wibox(s)      -- Original simple topbar
```

## Dependencies

The topbar uses only standard AwesomeWM widgets and should work out of the box. Optional dependencies for enhanced functionality:

- `scrot` - For screenshot functionality
- `playerctl` - For music control
- `gnome-control-center` - For settings panel

## Installation Notes

The topbar has been automatically integrated into your AwesomeWM configuration. The icons from Awful-DOTS have been copied to your configuration directory.
