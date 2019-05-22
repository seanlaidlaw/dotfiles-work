#!/usr/bin/env bash
# """
# this bash script uses stow to make symlinks from the inside of every visible folder in directory of
# scripts to the parent folder, e.g. from cd ~/.dotfiles/ && stow vim, will be run which will symlink
# the vim/.vimrc to ~/.vimrc.
#
# to work as designed, please setup your dotfiles folder in the home directory
# """
cd ~/.dotfiles
for folder in *; do
    if [ -d "${folder}" ]; then
        stow "${folder}"
    fi
done


# Additional steps if setting up computer for first time:
# curl -L https://get.oh-my.fish > install
# fish install --path=~/.local/share/omf --config=~/.config/omf

# omf install https://github.com/seanlaidlaw/sl-cmorrell-fish.git
# omf theme sl-cmorrell-fish
