# Set path
set -gx PATH /anaconda3/bin /anaconda3/condabin /Users/sl31/homebrew/bin /usr/local/bin /Users/sl31/homebrew/Cellar/ /usr/bin /bin /usr/sbin /sbin /usr/local/munki /opt/X11/bin
set -x EDITOR nvim
set -x dotfiles ~/.dotfiles
set -x QUTE_BIB_FILEPATH ~/.qutebrowser_bibliography
set -x PAGER bat

# abbreviations to go places
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

# easy file edit
abbr vv "$EDITOR $dotfiles/vim/.vimrc"
abbr vfsh "$EDITOR $dotfiles/fish/.config/fish/config.fish"
abbr veb '$EDITOR -c "set syntax=bib" $QUTE_BIB_FILEPATH'

# git abbreviations
abbr stashme "git stash --include-untracked"
abbr gdc "git diff --cached"
abbr gg "git st"
abbr gcm "git commit -m"
abbr gap "git add -p"
alias gri "git rebase -i "

# compression alias
#### make tarball without compression
function tarball
	set rootname (echo $argv | sed 's/\.[^.]*$//' | sed 's/\///g')
	tar cvf "$rootname.tar" $argv
end

function targz
	set rootname (echo $argv | sed 's/\.[^.]*$//' | sed 's/\///g')
	env GZIP=-9 tar cvzf "$rootname.tar.gz" $argv
end

function tarxz
	set rootname (echo $argv | sed 's/\.[^.]*$//' | sed 's/\///g')
	tar cvJf "$rootname.tar.xz" $argv
end


function cd
	if builtin cd $argv; and ls -F
	end
end
