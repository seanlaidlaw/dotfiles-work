# make bash completion case insensitive
bind 'set completion-ignore-case on'

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# cd into directory by typing directory name
shopt -s autocd

### KEY BINDINGS ###
# Vim Bindings
set -o vi

# escape vim insert mode with "jk"
bind '"jk":vi-movement-mode'

# c-l to clear screen
bind -x '"\C-l": clear'

# c-x c-e to edit readline in EDITOR
bind -m vi-insert '"\C-x\C-e": edit-and-execute-command'

# make up and down arrows show history based on whats already typed
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

### DEFAULT PROGRAMS ###
export EDITOR=vim
export PAGER=bat

### DEFAULT locations ###
dotfiles=$HOME/.dotfiles


### PRETTY PROMPT ###
export PS1="\[\e[0;34m\] \$(echo \"\${PWD%/*}\" | sed -e 's;\(/.\)[^/]*;\1;g')/\
`# this line shows first letter for each of the intermediate folders in the current dir`\
\[\e[0;35m\]\${PWD##*/} \[\e[0m\]\
`# this shows current dir`\
\$(if [ \$? == 0 ]; then echo ''; else echo '\[\e[0;41m\] ▲ \[\e[0m\]'; fi)\
`# this line sets a symbol depending on exit status of previous command`\
\[\e[0;33m\]❯\[\e[0m\] "\
`#this is the symbol i use to mark end of prompt and its colored yellow`

# enables color for tab completion
bind 'set colored-stats on'


### HISTORY SETTINGS ###
# append history instead of overwriting
shopt -s histappend
export HISTFILESIZE=
export HISTSIZE=

# dont add these commands to history
HISTIGNORE='ls:bg:fg:history'
HISTFILE=$HOME/.zhistory

# fit multiline commands to just one history line
shopt -s cmdhist

# store bash history instantly instead of on session close
PROMPT_COMMAND='history -a'


### ALIAS ###
# aliases to go places
alias gd='cd $dotfiles'

# command shorthand
alias pk="HOMEBREW_NO_AUTO_UPDATE=1 && brew install"
alias t="tmux new"
alias tls="tmux ls"
alias ta="tmux a -t"
alias v="$EDITOR"
alias c="$PAGER"
alias zz='source $dotfiles/bash/.bash_profile'
alias py="python3"
alias py2="python2.7"
alias mkdir="mkdir -pv"
alias chmox="chmod +x"

# ls abbrev
alias ls='ls --color=always'
alias ll='ls --color=always -l --human-readable'
alias la='ls --color=always -al --human-readable'

# easy file edit aliases
alias vv="$EDITOR $dotfiles/vim/.vimrc"
alias vfsh="$EDITOR $dotfiles/fish/.config/fish/config.fish"
alias vbrc="$EDITOR $dotfiles/bash/.bash_profile"
alias vbsh="vbrc"
alias vbib="$EDITOR -c 'set syntax=bib' $QUTE_BIB_FILEPATH"


# git aliases
alias stashme='git stash --include-untracked'
alias gdc='git diff --cached'
alias gg='git st'
alias d='git diff'
alias gcm='git commit -m '
alias gcl='git clone'
alias gap='git add --patch'
alias gri='git rebase -i '

# requires pushbullet-bash
# src: https://github.com/Red5d/pushbullet-bash
alias notifyme='xargs -I {} sh -c "pushbullet push iPhone note \"Command finished with args: {}\""'


# make a copy of argument in tarball
function tarball {
	rootname=$(echo $@ | sed 's/\.[^.]*$//' | sed 's/\///g')
	tar cvf "$rootname.tar" "$@"
}

# make a copy of argument in gz compressed tarball
function targz {
	rootname=$(echo $@ | sed 's/\.[^.]*$//' | sed 's/\///g')
	GZIP=-9 && tar cvzf "$rootname.tar.gz" "$@"
}

# make a copy of argument in xz compressed tarball
function tarxz {
	rootname=$(echo $@ | sed 's/\.[^.]*$//' | sed 's/\///g')
	tar cvJf "$rootname.tar.xz" "$@"
}



function cd {
	builtin cd "$@" && ls -F
}
