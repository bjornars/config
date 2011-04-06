# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignoreboth
export HISTSIZE=4500
export HISTFILESIZE=4500
shopt -s histappend
PROMPT_COMMAND='history -a'

unset MAILCHECK

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

svn_loc(){
    [[ `command -v svn` ]] || return
    local branch="" line=""

    while read -r line
    do 
        case "${line}" in
            URL*)
                branch="(${line/URL: })"
            ;;
        esac
    done < <(svn info 2>/dev/null)
    
    printf "${branch}"
}

bold=$(tput bold)
red=${bold}$(tput setaf 1) 
green=${bold}$(tput setaf 2) 
blue=${bold}$(tput setaf 4)
reset=$(tput sgr0)

command -v __git_ps1 || alias __git_ps1=true
PS1='${debian_chroot:+($debian_chroot)}\[${blue}\]\u@\h \[${green}\]\w\[${red}\]$(svn_loc)$(__git_ps1 " (%s)")\[${reset}\] \$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto -F'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
    alias grep='grep --color=auto'
fi

alias unrarall='find \( \( -iname "*.rar" -not -iname "*part*.rar" \) -or -iname "*.part01.rar" \) -exec unrar e {} \;'

alias ack=ack-grep

alias g=git
complete -o default -o nospace -F _git g

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

