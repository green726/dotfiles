#
# ~/.bashrc
#

# [[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach


export VISUAL=nvim
export EDITOR="$VISUAL"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen
_set_liveuser_PS1() {
    PS1='[\u@\h \W]\$ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="[\u@$iso_info \W]\$ "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1
ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}
alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
[[ "$(whoami)" = "root" ]] && return
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'
## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc
_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.
    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi
    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}
#------------------------------------------------------------
## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##
# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################
export TERM=kitty
alias ls='lsd -a'
alias awesomecon='nvim-qt ~/.config/awesome'
alias gitdots='sudo rm -rf ~/dotfiles/configs/* | sudo cp -r ~/.config ~/dotfiles/configs/'
alias mirror-update='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=43200 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist'
# alias cls='clear'
alias nvimcon='nvim-qt ~/.config/nvim'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/.git/ --work-tree=$HOME'

alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.11.1-complete.jar:$CLASSPATH" org.antlr.v4.Tool'

ugrep() {
    last=${@:$#} # last parameter 
    other=${*%${!#}} # all parameters except the last
    unbuffer $other | grep "$last"
}


eval "$(starship init bash)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/home/green726/coding/bash-scripts/
export NNN_OPENER=/home/green726/coding/bash-scripts/nnn-handlr-open.sh
export NNN_OPTS="c"

export PATH=$PATH:/home/green726/.config/nvim/scripts/linux-stuff
export PATH=$PATH:/home/green726/.local/bin
export PATH=$PATH:~/coding/SWO/Language/bin/Debug/net6.0/arch-x64/

export PATH=$PATH:~/.ghcup/bin/
export PATH=$PATH:~/.ghcup/ghc/9.2.4/bin/


# [[ ${BLE_VERSION-} ]] && ble-attach

# opam configuration
test -r /home/green726/.opam/opam-init/init.sh && . /home/green726/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
