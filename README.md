## Rofi Custom Menus

- **rofi-path-launcher**: by reading a json config file (default: ***~/.rofi-path-launcher.config.json***) launch applications by poviding them custom paths as arguments
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
