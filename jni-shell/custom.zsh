# Put me into $ZSH/custom/custom.zsh

# Optional Pi only
# alias cputemp='vcgencmd measure_temp'
# df -h | grep /dev/root | awk '{print "Available disk space: "$4}'
# temp_result=$(vcgencmd measure_temp)
# echo "CPU Temp: ${temp_result:5}"
# alias virtdesk='vncserver -geometry 1920x1080 -Authentication=VncAuth'
# printf "Virtual desktop:\tvirtdesk\n"

# Optional Arch based only
#
# Remember to copy jni_lib.sh
# source "$ZSH/custom/jni_lib.sh"

# jni_print_system_usage
# jni_print_used_root_space

# if jni_internet_connected ;
# then
# 	if (( $(jni_uptime_seconds) > 120 )) ;
# 	then
# 		jni_print_available_bw_space
# 	fi
# fi

# # Mac only
# printf "Go to iCloud:\ticloud\n"
# alias icloud='cd ~/Library/Mobile\ Documents/'

# To emulate the native Mac commands 'pbcopy' and 'pbpaste' on Linux
# alias pbcopy='xclip -selection clipboard'
# alias pbpaste='xclip -selection clipboard -o'

# Docker
# alias docker-compose='docker compose'
# alias dattach='docker attach --sig-proxy=false'
# printf "Docker attach:\t\tdattach <containername>\n"

# Kubernetes
alias k='kubectl'

# Common
alias gr='cd ~/Dev/git_rep'
# printf "Go to git rep:\t\tgitrep\n"

# Only show root mount point when calling duf
alias duf='duf -only-mp "/"'

# Optional if exa installed
# alias ls='exa --group-directories-first --icons'
# alias la='ls -a'
# alias l1='ls -1'

# Optional Let remove and move confirm
# alias mv='mv -i'
# alias rm='rm -i'

alias ..='cd ..'

alias svim='sudo vim'

alias grep='grep --ignore-case'


# Optional if gdu installed: Ignore PD mounted folders when exexuting Go Disk Usage tool
# alias gdu='gdu --ignore-dirs /proc,/dev,/sys,/run,/home/jni/PdChKaderSync,/home/jni/PdOneDriveSync'
# alias ncdu='echo "Use gdu please"'


# Optional if Alacritty installed: Workaround to get alacritty always working without having alacrrity's termin info having
# alias ssh='TERM=xterm-256color ssh'

# Optional GNOME only: Easily open nautilus without warnings and delays by 'open'
# function open() {
# 	nohup nautilus -w $1 > /dev/null 2>&1 &
# }


# Create a directory in cd into it
function mkcd() {
	mkdir -p "$1" && cd "$1"
}

# Run python http server on currend directory
function webserver() {
	# Check if port is set, otherwise use 8080
	if [ -z "$1" ]
	then
		port=8080
	else
		port=$1
	fi
	# Get local IP address
	ip=$(ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | head --lines 1)
	# ip=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | head --lines 1)
	echo "Visit: http://$ip:$port\n"
	python3 -m http.server $port
}

# Add your own Environment variables here:
# export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
# export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
# export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}


# # Optional: Prefer Neovim over Vim
# # Prefer Neovim over vim
# export VIM=/usr/share/nvim
# alias vim='nvim'
# alias svim='sudo nvim'


# V I M   A S   M A N  P A G E   V I E W E R
EDITOR=/usr/bin/vim
#
# Define vim is the view for man pages
# Add this line to your vimrc: let $PAGER=''
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
	    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
		-c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
		-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""


# # Optional: V I M   M O D E
# #
# #It is build in into zsh (as well as bash).
# # Run VIM Mode in Shell:
# bindkey -v

# # When switching to normal mode in zsh by hitting Escape, on the currently selected VIM mode will
# # be shown on the right (by using the following lines.
# #
# # Updates editor information when the keymap changes.
# function zle-keymap-select() {
#   zle reset-prompt
#   zle -R
# }
# zle -N zle-keymap-select

# function vi_mode_prompt_info() {
#   echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
# }

# # Define right prompt, regardless of whether the theme defined it
# RPS1='$(vi_mode_prompt_info)'
# RPS2=$RPS1

# # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
# export KEYTIMEOUT=1



# # TODO Optional Add FZF Support
#
# Install key bindings and complition for zsh in shell (if not installed via install script)
#  CTRL-T - Paste the selected files and directories onto the command-line 
#  CTRL-R - Paste the selected command from history onto the command-line 
#  ALT-C - cd into the selected directory 
#
# ** Trigger to work like
#  Files under your home directory
#  vim ~/**<TAB> 
#
#  Directories under ~/github that match `fzf`
#  cd ~/github/fzf**<TAB>
# Arch-Option1 source /usr/share/fzf/key-bindings.zsh
# Arch-Option2 source /usr/share/fzf/completion.zsh
# Debian-Option1 source /usr/share/doc/fzf/examples/key-bindings.zsh
# Debian-Option2 source /usr/share/doc/fzf/examples/completion.zsh
# Debian-Option3 source /usr/share/zsh/vendor-completions/_fzf

# # Optional if you use node version manager (nvm)
# # To run nvm the command has to be sourced.
# source /usr/share/nvm/init-nvm.sh

# # Optional run ripgrep
# # Install ripgrep first to have a rg command

# # Determines search program for fzf
# if type ag &> /dev/null; then
#    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
# fi
# # prefer rg over ag
# if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='rg --files --hidden'
# fi

# This starts the z to make easy fast navigation to folders
# See: https://github.com/rupa/z
# Available via 
# paru -S "z-git"
# brew install z
# Linux
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
# Mac
# . /usr/local/etc/profile.d/z.sh
