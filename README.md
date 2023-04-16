# Rofi Custom Menus

A collection of useful custom menu based on rofi.

- [Installation](#installation)
- [Scripts](#Scripts)
    - [rofi-path-launcher](#rofi-path-launcher)
    - [rofi-chromium-bookmarks](#rofi-chromiun-bookmarks)
- [Theming](#Theming)

## Installation

Just clone this repository and set a shortcut for each script.

```bash
git clone git@github.com:twoojoo/rofi-scripts.git
```

## Scripts

### rofi-path-launcher
By reading a json config file launch applications by poviding them custom paths as arguments

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

### rofi-chromiun-bookmarks 

automatically reads saved Chromium bookmarks and provide a menu for them

- Chromium bookmarks are stored in ***$HOME/.config/chromium/Default/Bookmarks***
- To use a custom bookmarks file run the script with this option: **-f|--bookmarks-file *&lt;path&gt;***
- gets bookmarks both from **bookmark_bar** and **other** bookmark folders (custom folders not yet implemented)
- **bookmark naming**:
	- be sure that bookamark names are **unique** among all bookmarks folders
	- for some reason, if the bookmark name contains more than 1 consective space character, the script won't be able to match the name with the url. Try to avoid this situation. Maybe this could be fixed in the script itself.
	- I find very proficient to use this pattern when naming bookmarks:
	
		***Personal/Utils/&lt;my-company-name&gt; - &lt;website-name&gt; [- &lt;section-name&gt;]***

		(e.g. "Personal - Gmail", "Personal - Github", "Personal - Github - Repositories", "Utils - Base64 - Encode", "Utils - Base64 - Decode", etc...)

		This helps a lot in keeping them tidy in the rofi menu.

<br>

## Theming

All the scripts will use the ***theme.rasi*** file that is placed in the same directory.
