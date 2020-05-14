# set PATH
# add my ~/bin path to PATH
[[ ":$PATH:" != *":$HOME/bin:"* ]] && PATH="$HOME/bin:$PATH"


if  [ -n "$BASH_VERSION" ]; then #if using bash
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

### HISTORY SETTINGS ###
# append history instead of overwriting
shopt -s histappend
export HISTFILESIZE=
export HISTSIZE=

# fit multiline commands to just one history line
shopt -s cmdhist
shopt -s lithist

# store bash history instantly instead of on session close
PROMPT_COMMAND='history -a'

### PRETTY PROMPT ###
export PS1="\[\e[0;34m\] \$(echo \"\${PWD%/*}\" | sed -e 's;\(/.\)[^/]*;\1;g')/\
`# this line shows first letter for each of the intermediate folders in the current dir`\
\[\e[0;35m\]\${PWD##*/} \[\e[0m\]\
`# this shows current dir`\
\[\e[0;33m\]❯\[\e[0m\] "\
`#this is the symbol i use to mark end of prompt and its colored yellow`
fi


### DEFAULT locations ###
export dotfiles=$HOME/.dotfiles
export dotfiles_private=$HOME/.dotfiles-private

### DEFAULT PROGRAMS ###
export EDITOR=nvim
command -v $EDITOR >/dev/null 2>&1 || export EDITOR=vim

export PAGER=bat
command -v $PAGER >/dev/null 2>&1 || export PAGER=less


# dont add these commands to history
HISTIGNORE='ls:bg:fg:history'
HISTORY_IGNORE=$HISTIGNORE # set zsh HISTORY_IGNORE to bash's
HISTFILE=$HOME/.zhistory

### LANGUAGE ###
#set as US to avoid errors with 'locale not found'
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8",
export LANG="en_US.UTF-8"

### ALIAS ###
# setup ealias for fish-like abbrv in zsh
# they have to be in a separate file
ealias_file="$HOME/.oh-my-zsh/custom/zsh-ealiases.zsh"
mkdir -p $(dirname "$ealias_file")
echo '' > $ealias_file
export YSU_IGNORED_ALIASES=()
function ealias {
	alias_name=$(echo "$1" | sed 's/=.*//g')
	YSU_IGNORED_ALIASES+=("$alias_name")
	echo "ealias $1" >> $ealias_file
}

# aliases to go places
alias gd='cd $dotfiles'
alias cd..='cd ../'                         # Go back 1 directory level
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'

# command shorthand
alias pk="HOMEBREW_NO_AUTO_UPDATE=1 && brew install"
alias t="tmux new"
alias tls="tmux ls"
alias ta="tmux a -t"
alias v="$EDITOR"
alias c="$PAGER"
alias chl="bat --style=plain"
alias zz='source $dotfiles/bash/.bash_profile'
alias py="python3"
alias py2="python2.7"
alias mkdir="mkdir -pv"
alias chmox="chmod +x"
ealias "o='open'"
alias grepcont="grep -Rli"

# ls abbrev
export CLICOLOR=1
alias ll='ls -l -h'
alias la='ls -al -h'

# easy file edit aliases
alias vv="$EDITOR $dotfiles/vim/.vimrc"
alias vfsh="$EDITOR $dotfiles/fish/.config/fish/config.fish"
alias vbrc="$EDITOR $dotfiles/bash/.bash_profile"
alias vzsh="$EDITOR $dotfiles/zsh/.zshrc"
alias vtmx="$EDITOR $dotfiles/tmux/.tmux.conf"
alias vsub="$EDITOR $dotfiles/bin/bin/sub.sh"
alias vsnp="$EDITOR $dotfiles/vim/snippets/sh.snippets"
alias vbsh="vbrc"
alias vbib="$EDITOR -c 'set syntax=bib' $QUTE_BIB_FILEPATH"


# git aliases
alias stashme='git stash --include-untracked'
ealias "gdc='git diff --cached'"
ealias "gg='git st'"
alias d='git diff'
ealias "gcm='git commit -m '"
alias gca='git commit --amend'
ealias "gcl='git clone'"
alias gap='git add --patch'
alias gl='lazygit'

# realpath alias
alias rp='readlink -f'
command -v realpath foo >/dev/null 2>&1 && alias rp='realpath '

# LSF alias
alias bsubthis6="bsub -I -R'select[mem>6000] rusage[mem=6000]' -M6000 -n 1 -R'span[hosts=1]'"
alias bsubthis30="bsub -I -R'select[mem>30000] rusage[mem=30000]' -M30000 -n 1 -R'span[hosts=1]'"

# make symlink in home to current directory
alias lnh='ln -s $(realpath .) $(realpath ~)'

alias tre="tree -C | $PAGER"

# requires pushbullet-bash
# src: https://github.com/Red5d/pushbullet-bash
alias notifyme='xargs -I {} sh -c "pushbullet push iPhone note \"Command finished with args: {}\""'


function cd {
	builtin cd "$@" && ls -F
}

function cdir () {
	cd "$(dirname "$@")"
}

# moves file in argument to current directory
function mvh () {
	for f in "$@"; do
		mv "$f" .
	done
}

# copies file in argument to current directory
function cph () {
	for f in "$@"; do
		cp "$f" .
	done
}

# moves file in first argument to folder in second argument, then create a symlink back to original
# location. allows moving files without having worry about where they're put
function mvln () {
	source_file="$(rp $1)"
	destination_file="$(rp $2)"

	mv "$source_file" "$destination_file"
	ln -s "$destination_file" "$source_file"
}

# run mvln to current dir, avoids having to write "./" every time if we have multiple files
function mvlnh () {
	for f in $@; do
		mvln "$f" "./"
	done
}


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

# replace file in argument with gzip version
function gzthis () {
	for f in $@; do
		gzip -9 "$f"
	done
}

# replace file in argument with bgzipped version
function bgzthis () {
	for f in $@; do
		bgzip -9 "$f"
	done
}

# replace file in argument with xzzipped version
function xzthis () {
	for f in $@; do
		xz -9 --extreme --threads=0 "$f"
	done
}


function fakescan () {
	for f in $@; do
		rootname=$(echo "$f" | sed 's/\.[^.]*$//' | sed 's/\///g')
		convert -density 90 "$f" -rotate 0.5 -attenuate 0.2 +noise Multiplicative -colorspace Gray "$rootname.fake_scan_output.pdf"
	done
}

# git add and git commit in same cmd
function gitcc () {
# first argument is file and second is commit message
	echo "$1"
	echo "$2"
	git add "$1"
	git commit -m "$2"
}

function bkillall () {
	for i in `bjobs | sed 's/ /\t/g' | cut -f 1 | xargs`
	do
		bkill $i
	done
}

function gri () {
    git stash --include-untracked && \
    echo "" && \
    echo "changes in git directory have been stashed, remember to git stash pop' after rebase" && \
    git stash list --color=always --pretty="%C(green)%h %>(14)%Cblue%cr %C(white)%gs" | head -n 1 && \
    echo "" && \
    git rebase -i "$@"~1
}

function wdiffarg () {
	diff -u <(echo "$1" ) <(echo "$2") | colordiff | diff-highlight
}


function vimd5 {
	$EDITOR -d <(find "$1" -type f -exec md5sum {} + | sort -k 2 | sed 's/ .*\// /') <(find "$2" -type f -exec md5sum {} + | sort -k 2 | sed 's/ .*\// /')
}

# scph alias to copy file from lustre to local
function scph () {
	cluster_prefix="farm5"
	for f in "$@"; do
		scp "${cluster_prefix}:/$f" .
	done
}

function cram2bam () {
	for cram in "$@"
	do
		bamname="$(echo $cram | sed 's/.cram$//g')"
		bsub \
		-R"span[hosts=1]" \
		-o cram2bam.o -e cram2bam.e  \
		-q normal \
		-G team176 \
		-R 'select[mem>=2000] rusage[mem=2000]' -M2000 \
		samtools view -b -T ~/ref/hg19_DNA_genome.fa -o "$bamname".bam "$cram"
	done
}

function dir1_files_not_in_dir2() {
	find "$1/" "$2/" "$2/" -printf '%P\n' | sort | uniq -u | $PAGER
}





# LOAD SYSTEM SPEICIFC BASH_PROFILE
# this allows us to keep this file as universal
# and system specific paths can be kept apart
my_host="$HOSTNAME"
if [ -z "$my_host" ]; then
	my_host="$HOST"
fi

if [ "$my_host" = "farm5-head2" ]; then
	source "$dotfiles_private/bash/.bashrc_specific_sangerfarm5"
fi




# QFC SETUP for real-time multi-directories matching
# INSTALL WITH: git clone https://github.com/pindexis/qfc $HOME/.qfc
# This allows c-f to start qfc
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"


if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
	tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi
