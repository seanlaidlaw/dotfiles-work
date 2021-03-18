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
	if [ "${folder}" != "no_stow" ]; then
	    stow "${folder}"
	fi
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
    git clone "https://github.com/seanlaidlaw/expand-ealias.plugin.zsh.git" "expand-ealias"
    git clone "https://github.com/IngoMeyer441/zsh-easy-motion.git" "$HOME/.oh-my-zsh/custom/"
    git clone "https://github.com/KKRainbow/zsh-command-note.plugin" "$HOME/.oh-my-zsh/custom/plugins/zsh-command-note"
    git clone "https://github.com/MikeDacre/careful_rm.git"
    git clone "https://github.com/urbainvaes/fzf-marks" "$HOME/.oh-my-zsh/custom/fzf-marks"
    cd -
fi


# vim-plug installation
[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ] && sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# TPM installation
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Installing xmenu
# mkdir -p ~/Applications && cd ~/Applications && git clone https://github.com/uluyol/xmenu.git && cd xmenu && make

# setup symlink between system qutebrowser userscripts dir to dotfiles
[ "$(uname)" == "Darwin" ] && [ -d "$dotfiles/qutebrowser/.qutebrowser/userscripts/" ] && [ ! -d "/Users/$USER/Library/Application Support/qutebrowser/userscripts" ] && ln -s "$dotfiles/qutebrowser/.qutebrowser/userscripts/" "/Users/$USER/Library/Application Support/qutebrowser/userscripts"


[ "$(uname)" == "Darwin" ] && ln -s "/Users/$USER/Library/Preferences/qutebrowser/autoconfig.yml" "$dotfiles/qutebrowser/.qutebrowser/autoconfig.yml"

# set keyboard speed to lowest setting for fast arrow key movements
defaults write NSGlobalDomain KeyRepeat -int 1

# copy over Mac Services
if [ "$(uname)" == "Darwin" ]; then
    for service in no_stow/Services/*; do
	if [ -d "$service" ]; then
	    service=$(realpath "$service")
	    ln -s "$service" $HOME/Library/Services/
	fi
    done
fi

# setup Ubersicht
mkdir -p "$HOME/Library/Application Support/Übersicht/widgets"
cd "$HOME/Library/Application Support/Übersicht/widgets" && git clone "https://github.com/seanlaidlaw/simple-bar.git"

# symlink ultisnips so we can track them in dotfiles repo
ln -s "$HOME/.dotfiles/vim/ultisnips" "$HOME/.config/coc/ultisnips/"



