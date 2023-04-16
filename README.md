## Rofi Custom Menus

### Scripts list

<br>

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
<br>

- **rofi-chromiun-bookmarks**: automatically reads saved Chromium bookmarks and provide a menu for them
	- Chromium bookmarks are stored in ***$HOME/.config/chromium/Default/Bookmarks***
	- gets bookmarks both from **bookmark_bar** and **other** bookmark collections (custom folders not yet implemented)
	- be sure that bookamark names are **unique**
	- for some reason if the bookmark name contains more than 1 consective space character, the script won't be able to match the name with the url. Try to avoid this situation. Maybe this could be fixed in the script itself.
	- I find very proficient to use this pattern for naming bookmarks:
	
		***Personal/Utils/&lt;my-company-name&gt; - &lt;website-name&gt; [- &lt;section-name&gt;]***

		(e.g: "Personal - Github", "Personal - Github - Repositories", "Utils - Base64 - Encode", "Utils - Base64 - Decode", etc...)

### Theming

All the scripts will use the ***theme.rasi*** file that is placed in the same directory.
