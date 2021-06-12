J N I   V I M   C O N F I G U R A T I O N 
=========================================

This script work only on user level and must not be executed with 'sudo'.

## What it will perform
* Removes an existing version of vim plugin manager 'vim plug'.
* Installs the current version of 'vim plug' from git hub master.
* Overwrites any existing `~/.vimrc` file with the `vimrc` file in this directory.


## What you will have to do post installation
Run `:PlugInstall` inside vim and reload vim.

## Configuration Overview

### Genaral
* Enables synstax highligting
* Furhter better visualizations
* Better formating (e.g. standard tab stop width)
* Better search experience (e.g. case-insensitive by default)
* Removes swapfile clutter.
* Sets Space as leader key
* Sets "jj" to exit normal mode.
* Sets "K" (shift k) to split a line.
* Sets leader y to copy the selection to system clipboard
* Sets leader p to paste from system clipboard

### Plugin 'Undotree'
	Make sure to create mkdir -p ~/.vim/undodir
	Call it by <Space> plus 'u' (custom binding)

### Plugin 'fzf'
	Call it by <Ctrl> plus 'f' inside a file (custom binding)
	Call <Space> plus 'f" to find a file (custom binding)	

### Plugin 'lightline'
	It's just a the nicer status bar at the bottom

### Plugin 'Gruvbox'
	Custom vim theme

### Plugin 'Nerdcommenter'
	A language sensitive commenting helper
	Use <Space> plus c plus <Space> to toggle commenting.

### Plugin 'Autocomplete Popup'
	This plugin will automatically pop up autocompletion
	Use <Ctrl> plus 'p' for autocomplete (word spelling)
When the menu is shown...
	right arrow or Tabulator will select the item.
	left arrow will make the autocompletion menu disappear
	arrows up and down will navigate over the items.