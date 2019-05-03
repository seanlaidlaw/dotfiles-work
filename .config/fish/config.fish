# Set path
set -gx PATH /anaconda3/bin /anaconda3/condabin /Users/sl31/homebrew/bin /usr/local/bin /Users/sl31/homebrew/Cellar/ /usr/bin /bin /usr/sbin /sbin /usr/local/munki /opt/X11/bin
set -x EDITOR vim
set -x dotfiles /Users/sl31/Documents/dotfiles-work
set -x PAGER bat

abbr gd "cd $dotfiles"
abbr pk "brew install"
abbr t "tmux new"
abbr tls "tmux ls"
abbr ta "tmux a -t"
abbr v "$EDITOR"
alias c "$PAGER"
abbr zz "omf reload"
abbr py "python3"
abbr py2 "python2.7"
abbr pwdpb "pwd | pbcopy"
alias mkdir "mkdir -pv"
abbr chmox "chmod +x"
abbr vv "cd $dotfiles; $EDITOR .vimrc"
abbr vfsh "cd $dotfiles; $EDITOR config.fish"
abbr stashme "git stash --include-untracked"
abbr gdc "git diff --cached"
