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
# install oh-my-zsh
[ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install non default zsh plugins (if custom plugin folder is empty)
if [[ $(ls $HOME/.oh-my-zsh/custom/plugins | wc -l) -le 1 ]]; then
    cd "$HOME/.oh-my-zsh/custom/plugins" && \
    git clone "https://github.com/zdharma/fast-syntax-highlighting.git"
    git clone "https://github.com/zdharma/history-search-multi-word.git"
    git clone "https://github.com/zsh-users/zsh-autosuggestions"
    git clone "https://github.com/chrissicool/zsh-256color"
    git clone "https://github.com/hlissner/zsh-autopair"
    git clone "https://github.com/zpm-zsh/undollar"
    git clone "https://github.com/MichaelAquilina/zsh-you-should-use.git" "$HOME/.oh-my-zsh/custom/plugins/you-should-use"
    git clone "https://github.com/agkozak/zsh-z"
    cd -
fi

# Vundle installation
[ ! -d "$HOME/.vim/bundle/Vundle.vim" ] &&  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Installing xmenu
# mkdir -p ~/Applications && cd ~/Applications && git clone https://github.com/uluyol/xmenu.git && cd xmenu && make

# setup symlink between system qutebrowser userscripts dir to dotfiles
[ "$(uname)" == "Darwin" ] && [ -d "$dotfiles/qutebrowser/.qutebrowser/userscripts/" ] && [ ! -d "/Users/$USER/Library/Application Support/qutebrowser/userscripts" ] && ln -s "$dotfiles/qutebrowser/.qutebrowser/userscripts/" "/Users/$USER/Library/Application Support/qutebrowser/userscripts"


