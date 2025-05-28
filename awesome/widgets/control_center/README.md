# Control Center Integration Complete

## Overview
The AwesomeWM control center from Awful-DOTS has been successfully integrated into your AwesomeWM configuration. The control center provides a modern, feature-rich interface for system controls and information.

## Features Implemented

### 🎛️ Main Control Center Components
- **User Profile Header**: Displays user information (Santi) with profile picture
- **Header Buttons**: Power and notification controls
- **Control Buttons**: WiFi, Bluetooth, Do Not Disturb, Silent Mode, Night Mode
- **Volume Slider**: Real-time volume control with amixer integration
- **Brightness Slider**: Screen brightness control with light command
- **Music Player**: Media controls with playerctl integration

### 🖱️ Access Methods
1. **Topbar Settings Button**: Click the settings button in the topbar control buttons
2. **Keyboard Shortcut**: Press `Super + Escape` to toggle the control center
3. **Signal Control**: The control center responds to AwesomeWM signals

### 🔧 System Integration

#### Volume Control
- **Commands**: `amixer set Master [value]`
- **Auto-update**: Timer refreshes volume display every 2 seconds
- **Range**: 0-100% with smooth slider control

#### Brightness Control  
- **Commands**: `light -S [value]` and `light -A [value]`
- **Auto-update**: Timer refreshes brightness display every 2 seconds
- **Range**: 1-100% with smooth slider control

#### Network Controls
- **WiFi Toggle**: `nmcli radio wifi on/off`
- **Bluetooth Toggle**: `bluetoothctl power on/off`

#### Audio Controls
- **Silent Mode**: Mutes/unmutes system audio
- **Music Player**: Play/pause, next/previous with playerctl

#### System Controls
- **Night Mode**: Toggles redshift for eye comfort
- **Do Not Disturb**: Controls notification visibility

## File Structure
```
widgets/control_center/
├── init.lua              # Module entry point
├── main.lua              # Main control center widget
├── color.lua             # Color scheme
├── user_profile.lua      # User configuration
├── assets/               # Icons and images
├── header/
│   ├── header.lua        # User profile header
│   └── button.lua        # Header action buttons
├── buttons/
│   ├── container.lua     # Button factory
│   ├── left.lua          # WiFi, Bluetooth, DND buttons
│   └── right.lua         # Silent, Night mode buttons
├── sliders/
│   ├── volume_slider.lua # Volume control
│   ├── brightness_slider.lua # Brightness control
│   └── sliders.lua       # Slider container
└── music/
    └── music.lua         # Music player widget
```

## Integration Points

### Topbar Integration
- `widgets/topbar/control_buttons.lua` - Settings button triggers control center
- Control center imports: `require("widgets.control_center.main")`

### Keybinding Integration
- `bindings/global/key.lua` - Super+Escape keybinding added
- Control center accessible via keyboard shortcut

### Theme Integration
- Colors adapted from Awful-DOTS theme
- Consistent with existing topbar styling
- Rounded corners and modern design elements

## Dependencies
- **amixer**: Volume control (typically pre-installed)
- **light**: Brightness control (`sudo pacman -S light` on Arch)
- **playerctl**: Media control (`sudo pacman -S playerctl`)
- **nmcli**: Network control (part of NetworkManager)
- **bluetoothctl**: Bluetooth control (part of bluez)
- **redshift**: Night mode (`sudo pacman -S redshift`)

## Usage Instructions

### Opening the Control Center
1. Click the settings button (gear icon) in the topbar
2. Press `Super + Escape` on keyboard
3. The control center will appear in the top-right corner

### Using Controls
- **Volume Slider**: Click and drag to adjust volume
- **Brightness Slider**: Click and drag to adjust screen brightness
- **Toggle Buttons**: Click to enable/disable WiFi, Bluetooth, etc.
- **Music Controls**: Play/pause and track navigation
- **Night Mode**: Toggle blue light filter

### Customization
- Edit `widgets/control_center/user_profile.lua` to change user settings
- Modify `widgets/control_center/color.lua` for different colors
- Update asset images in `widgets/control_center/assets/`

## Technical Notes

### Auto-updating Timers
- Volume and brightness sliders automatically refresh every 2 seconds
- Music player information updates every 3 seconds
- Timers are properly managed to prevent resource leaks

### Error Handling
- All system commands wrapped with proper error handling
- Graceful fallbacks for missing dependencies
- Non-blocking operations to maintain UI responsiveness

### Signal System
- Control center responds to `widget::control` signal for hiding
- Properly integrated with AwesomeWM's signal system

## Troubleshooting

### Control Center Not Appearing
- Check AwesomeWM logs for errors
- Ensure all required modules are in the correct path
- Verify topbar is using the new fancy topbar system

### Sliders Not Working
- Install missing dependencies (light, amixer)
- Check user permissions for brightness control
- Verify audio system is properly configured

### Toggle Buttons Not Responding
- Install required command-line tools
- Check system service status (NetworkManager, Bluetooth)
- Verify user has permission to control these services

## Success!
Your AwesomeWM configuration now includes a fully functional control center that matches the design and functionality of the Awful-DOTS configuration. The control center provides quick access to essential system controls and maintains the modern aesthetic of your desktop environment.
