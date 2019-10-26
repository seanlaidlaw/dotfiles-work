# Set path
set -gx PATH /anaconda3/bin /anaconda3/condabin /Users/sl31/homebrew/bin /usr/local/bin /Users/sl31/homebrew/Cellar/ /usr/bin /bin /usr/sbin /sbin /usr/local/munki /opt/X11/bin ~/bin
set -x EDITOR nvim
set -x dotfiles ~/.dotfiles
set -x QUTE_BIB_FILEPATH ~/.qutebrowser_bibliography
set -x PAGER bat

# abbreviations to go places
abbr gd "cd $dotfiles"
abbr cd.. 'cd ../'                         # Go back 1 directory level
abbr .. 'cd ../'                           # Go back 1 directory level
abbr ... 'cd ../../'                       # Go back 2 directory levels
abbr .3 'cd ../../../'                     # Go back 3 directory levels
abbr .4 'cd ../../../../'                  # Go back 4 directory levels
abbr .5 'cd ../../../../../'               # Go back 5 directory levels
abbr .6 'cd ../../../../../../'


# command shorthand
alias pk "env HOMEBREW_NO_AUTO_UPDATE=1 brew install"
abbr t "tmux new"
abbr tls "tmux ls"
abbr ta "tmux a -t"
alias v "$EDITOR"
alias c "$PAGER"
abbr zz "omf reload"
abbr py "python3"
abbr py2 "python2.7"
abbr pwdpb "pwd | pbcopy"
alias mkdir "mkdir -pv"
abbr chmox "chmod +x"
alias ejectall "osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true)'"
alias lnh 'ln -s (realpath .) (realpath ~)'

# easy file edit
abbr vv "$EDITOR $dotfiles/vim/.vimrc"
abbr vfsh "$EDITOR $dotfiles/fish/.config/fish/config.fish"
abbr veb '$EDITOR -c "set syntax=bib" $QUTE_BIB_FILEPATH'

# use vi keys
fish_vi_key_bindings

# bind jk to escape mode
bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint;end"
bind -M insert kj "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint;end"

# git abbreviations
abbr stashme "git stash --include-untracked"
abbr gdc "git diff --cached"
abbr gg "git st"
abbr d "git diff"
abbr gca "git commit --amend"
abbr gcm "git commit -m"
abbr gap "git add -p"

# requires pushbullet-bash
# src: https://github.com/Red5d/pushbullet-bash
alias notifyme 'xargs -I {} sh -c "pushbullet push iPhone note \"Command finished with args: {}\""'



# set Oh My Fish theme:
# this can be downloaded from https://github.com/seanlaidlaw/sl-cmorrell-fish
omf theme sl-cmorrell-fish

# set fish colors to colors of vim-deep-space
set -U fish_color_autosuggestion 51617d
set -U fish_color_comment 51617d
set -U fish_color_command 608cc3
set -U fish_color_operator 56adb7
set -U fish_color_redirection 56adb7
set -U fish_color_param 8f72bf
set -U fish_color_quote b9ca4a
set -U fish_color_quote b5a262
set -U fish_color_error d54e53
set -U fish_color_escape 00a6b2
set -U fish_color_valid_path \x2d\x2dunderline



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

function gzthis
    for f in $argv
	gzip -9 "$f"
    end
end

function xzthis
    for f in $argv
	xz -9 --extreme --threads=1 "$f"
    end
end



function cd
	if builtin cd $argv; and ls -F
	end
end

function symlink
	ln -s (realpath $argv[1]) (realpath $argv[2])
end

function rp
    realpath "$argv" | pbcopy
end

function gri
    git stash --include-untracked && \
    echo "" && \
    echo "changes in git directory have been stashed, remember to git stash pop' after rebase" && \
    git stash list --color=always --pretty="%C(green)%h %>(14)%Cblue%cr %C(white)%gs" | head -n 1 && \
    echo "" && \
    git rebase -i "$argv[1]"~1
end
