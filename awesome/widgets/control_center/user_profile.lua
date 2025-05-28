-- User Profile Configuration
local user_profile = {
	name = "Santi",
	image_path = os.getenv("HOME") .. "/.config/awesome/widgets/control_center/assets/user.png",
	dnd_status = false,
	browser = 'firefox ',
	file_manager = 'thunar ',
	terminal = 'kitty',
	icon_theme_path = "/.icons/Papirus/32x32/apps/",
	wallpaper = os.getenv("HOME") .. '/.config/awesome/assets/wallpaper.png',
	fallback_password = "1234",
}

return user_profile
