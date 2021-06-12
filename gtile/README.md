J N I   G T I L E   C O N F I G U R A T I O N 
=============================================

This script work only on user level and must not be executed with 'sudo'.

## What it will perform
* Backups existing settings in `./gtile_settings.backup`
* Loads and overwirtes GTile settings stored in `./gtile_settings.input` via Gnome's dconf editor. 
* Existing settings will be overriden.


## What you will have to do post installation
Changes should be applied immediately.
If this is not the case, hit Alt + F2 to open Gnome command window and enter `r` to reload the 
shell.


## Configuration Details

GTile is a manual Tiling manager provided as Gnome extension. The extension's settings are stored. Available for installation via Gnome extensions or via Github.
[https://github.com/gTile/gTile]

Main features of this configuration
* Concentration on keyboard input.
* Leaves place for a dock on the left side.
* General window margin set to 30 px
* All placements are done by invocation via <Ctrl> + <Alt> + ?

| Key   | Stroke 1                        | Stroke 2         |
| ----- | ------------------------------- | ---------------- |
| a     | Left 1/3                        | Left 2/3         | 
| s     | Middle 1/3                      | Fullscreen       | 
| d     | Right 1/3                       | Right 2/3        | 
| q     | Left Upper 1/3                  | Left Upper 2/3   | 
| w     | Middle Upper 1/3                | Upper Full       | 
| e     | Right Upper 1/3                 | Right Upper 2/3  | 
| z     | Left Bottom 1/3                 | Left Bottom 2/3  | 
| x     | Middle Bottom 1/3               | Bottom Full      | 
| c     | Right Bottom 1/3                | Right Bottom 2/3 | 
| Space | Centered 1/2 witdth             | Centered almost 2/3 |
| h     | Left half with larger margins   | Left half full |
| l     | Right half with larger margins  | Right half full |