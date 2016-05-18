# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



alias GLOL='git log --oneline --graph --decorate --all'
alias GLOG='git log --show-signature --stat'
alias GF='git fetch --all'

alias GM='git fetch --all ; git merge --ff-only'
complete -o default -F nospace  -F _git_merge  GM # TODO: almost works...

alias GMj='git fetch --all ; echo merging_JAKUB ; git merge --ff-only jakubk/master'
alias GMrob='git fetch --all ; echo merging_ROBERT ; git merge --ff-only rob/master'

alias GS='date -u ; git log -1 | head -n 3 && echo "Sub:" && git submodule status && git status'
alias GR='git remote -v'

alias GCP='git cherry-pick'

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;30m\][$(date +%Y-%m-%d_%H:%M:%S)] \[\033[01;38m\]\u@\[\033[01;34m\]\h\[\033[00m\]:\[\033[01;32m\]\w\[\033[01;33m\]($(__git_ps1 "%s"))'

PATH="$PATH:$HOME/.bin/"


# settings for Open-Transactions / and newcli
# export CC="$HOME/.local/bin/clang" ; export CXX="$HOME/.local/bin/clang++" ; export CPP="$HOME/.local/bin/clang -E"
# export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH
# export CMAKE_PREFIX_PATH=/home/rafal/.local/
# export LD_LIBRARY_PATH=/home/rafal/.local/lib/x86_64-linux-gnu/:/home/rafal/.local/lib:/home/rafal/.local/lib64:/home/rafal/.local/include
# export PKG_CONFIG_PATH=/home/rafal/.local/lib/x86_64-linux-gnu/pkgconfig/:/home/rafal/.local/lib/pkgconfig:
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

export TZ="/usr/share/zoneinfo/UTC"

(( BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] >= 3 || BASH_VERSINFO[0] > 4 )) && {
	_readline_git_toplevel() {
		local -n r=READLINE_LINE i=READLINE_POINT
		local dir;
		local text;
		dir=$(git rev-parse --show-toplevel 2>/dev/null) || return 0
		text="${dir}/" # the text to add
		r=${r:0:i}$text${r:i}
		(( i += ${#text} ))
	}
	bind -x '"\C-g":"_readline_git_toplevel"'
}

(( BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] >= 3 || BASH_VERSINFO[0] > 4 )) && {
	_readline_git_branchname() {
		local -n r=READLINE_LINE i=READLINE_POINT
		local dir;
		local text;
		textraw=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return 0
		text="${textraw}" # the text to add
		r=${r:0:i}$text${r:i}
		(( i += ${#text} ))
	}
	bind -x '"\C-b":"_readline_git_branchname"'
}


EDITOR='vim';
export EDITOR

function edit_kws() {
	echo "Killing whitespaces on $1"
	sed -i 's/[ \t]*$//' "$1"
}

xset r rate 160 60


function __ps_netif_glaxy {
	# 17: galaxy0: <POINTOPOINT,
	netif_galaxy=$( ip a | egrep 'galaxy[0-9]+:' | sed -e 's/.*galaxy\([0-9]\+\):.*/\1/g' )
	netif_galaxy_count=$( ip a | egrep 'galaxy[0-9]+:' | sed -e 's/.*galaxy\([0-9]\+\):.*/\1/g' | wc -l )
	[[ $netif_galaxy_count == "1" ]] && {
		echo -n -e '\e[44m\e[33m'
		echo -n " galaxy $netif_galaxy "
		# lame? way to extract ipv6 address: 
		# ip a | grep galaxy -A 10 | grep inet6 | head -n 1 | sed 's/[ ]*inet6 \([0-9a-f:]\+\)\/.*$/\1/g'
		addr=$( ip a | grep galaxy -A 10 | grep inet6 | head -n 1 | sed 's/[ ]*inet6 \([0-9a-f:]\+\)\/.*$/\1/g' )
		echo -n -e '\e[32m'
		echo -n "$addr "
	}
}

function __ps_netif_privnet {
	# TODO make this hacked code nicer
	# prva2xG@if8:
	netif_guest=$( ip a | egrep 'prv.+x?@if' | sed -e 's/.*prv\(.\+\).G@.*/\1/g' )
	netif_guest_count=$( ip a | egrep 'prv.+x?@if' | sed -e 's/.*prv\(.\+\).G@.*/\1/g' | wc -l )
	[[ $netif_guest_count == "1" ]] && {
		# echo "You are in guest network [$netif_guest]"
		echo -n -e '\e[35m'
		echo "<guest $netif_guest>"
	}
}

# [CONFIG] remove the ending $ from your default PS above, or use this one instead (uncomment next 1 line):
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;30m\][$(date +%Y-%m-%d_%H:%M:%S)] \[\033[01;38m\]\u@\[\033[01;34m\]\h\[\033[00m\]:\[\033[01;32m\]\w\[\033[01;33m\]($(__git_ps1 "%s"))'

PS1="${PS1}\$(__ps_netif_privnet)\$(__ps_netif_glaxy)"
PS1="${PS1}"'\[\033[00m\]\$ '


