# Rofi Custom Utils

A collection of useful custom menus based on [rofi](https://github.com/davatorium/rofi) fully written in bash syntax.

- [Dependencies](#dependencies)
- [Installation](#installation)
- [Scripts](#Scripts)
    - [rofi-path-launcher](#rofi-path-launcher)
    - [rofi-chromium-bookmarks](#rofi-chromiun-bookmarks)
    - [rofi-window-switcher](#rofi-window-switcher)
    - [rofi-todo-list](#rofi-window-switcher)
- [Theming](#Theming)

## Dependencies

- **nerd-fonts** (all menus)
- **xdotool** (rofi-todo-list)

## Installation

Just clone this repository and set a shortcut for each script.

```bash
git clone git@github.com:twoojoo/rofi-scripts.git
```

I personally use the following shortcuts (set via i3wm config file):

- **Alt+Enter**: rofi-chromium-bookmarks
- **Shifr+Enter**: rofi-window-switcher
- **Ctrl+Alt+Enter**: rofi-path-launcher
- **Ctrl+Shift+Enter**: rofi-todo-list

## Scripts

### rofi-path-launcher
By reading a json config file launch applications by poviding them saved custom paths as arguments

- default config file: ***~/.rofi-path-launcher.config.json*** (will be created at the first run if doesn't exist yet)
- can add or remove programs and paths directly form the rofi menu (*edit* option to be implemented)
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

- options:
    - **-f|--bookmarks-file *&lt;path&gt;***: use a different bookmarks file. Must have the same structures of Chromium's one (default: ***$HOME/.config/chromium/Default/Bookmarks***)
    - **-b|--alt-browser *&lt;browser&gt;***: provide an alternative browser (*its command*) to open the urls (e.g. *-b firefox, -b konqueror, -b lynx,* etc...)
    - **-c|--post-command *&lt;cmd&gt;***: execute a command after the bookmark is opened (I personally use this option to immediately switch to the workspace that contains the Chromium window)
    - **-d|--debug**: run in debug mode

- gets bookmarks both from **bookmark_bar** and **other** bookmark folders (custom folders not yet implemented)
- **bookmarks naming**:
	- be sure that bookamarks names are **unique** among all bookmarks folders
	- for some reason, if a bookmark name contains more than 1 consective space character, the script won't be able to match the name with the url. Try to avoid this situation. Maybe this could be fixed in the script itself.
	- I find very proficient to use this pattern when naming bookmarks:
	
		***Personal/Utils/&lt;my-company-name&gt; - &lt;website-name&gt; [- &lt;section-name&gt;]***

		(e.g. *"Personal - Gmail", "Personal - Github", "Personal - Github - Repositories", "Utils - Base64 - Encode", "Utils - Base64 - Decode"*, etc...)

		This helps a lot keeping them tidy in the rofi menu.
- **todo**: 
    - implement a remove option (an add options is also possible but it's way more easy to create the bookmark from the chromium tab itself)
    - fix consecutive space char bug
<br>

### rofi-todo-list 

A basyc, yet effective, to do list completely handled by a set of rofi menus.

- default config file: ***$HOME/.rofi-todo-list.config.json***
<br>

### rofi-window-switcher

Just a wrapper around the native rofi window mode to use the same theme as the other scripts.

## Theming

All the scripts will use the ***theme.rasi*** file that is placed in the same directory.
