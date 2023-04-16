## Rofi Custom Menus

- **rofi-path-launcher**: by reading a json config file launch applications by poviding them custom paths as arguments
	- default config file: ***~/.rofi-path-launcher.config.json*** (will be created at the first run if doesn't exist yet)
	- example config (*&lt;path&gt;* is a placeholder for the selected path): 
	```json
	{
	    "CodeOSS": {
	        "command": "code <path>",
	        "paths": [
	            "~/Scripts/rofi",
	            "~/Projects/dotfiles"
	        ]
	    },
	    "SublimeText4": {
	        "command": "subl <path>",
	        "paths": [
	            "~/Scripts/rofi",
	            "~/Projects"
	        ]
	    },
	    "Kate": {
	        "command": "kate <path>",
	        "paths": [
	            "~/Notes"
	        ]
	    }
	}
	```

- **rofi-chromiun-bookmarks**: automatically reads saved Chromium bookmarks and provide a menu for them
	> Chromium bookmarks are stored in ***$HOME/.config/chromium/Default/Bookmarks***
