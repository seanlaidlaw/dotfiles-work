#!/usr/bin/env bash
# """
# this bash script uses stow to make symlinks from the inside of every visible folder in directory of
# scripts to the parent folder, e.g. from cd ~/.dotfiles/ && stow vim, will be run which will symlink
# the vim/.vimrc to ~/.vimrc.
#
# to work as designed, please setup your dotfiles folder in the home directory
# """

# Additional steps if setting up computer for first time:
# install oh-my-zsh
[ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printf "stowing dotfiles to home..."
cd ~/.dotfiles
for folder in *; do
    if [ -d "${folder}" ]; then
	if [ "${folder}" != "no_stow" ]; then
	    stow "${folder}"
	fi
    fi
done
printf "done.\n\n"


# Install non default zsh plugins (if custom plugin folder is empty)
mkdir -p $HOME/.oh-my-zsh/custom/plugins
cd "$HOME/.oh-my-zsh/custom/plugins"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ] && git clone "https://github.com/zdharma/fast-syntax-highlighting.git"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/history-search-multi-word" ] && git clone "https://github.com/zdharma/history-search-multi-word.git"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ] && git clone "https://github.com/zsh-users/zsh-autosuggestions"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-256color" ] && git clone "https://github.com/chrissicool/zsh-256color"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autopair" ] && git clone "https://github.com/hlissner/zsh-autopair"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/undollar" ] && git clone "https://github.com/zpm-zsh/undollar"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/you-should-use" ] && git clone "https://github.com/MichaelAquilina/zsh-you-should-use.git" "$HOME/.oh-my-zsh/custom/plugins/you-should-use"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-z" ] && git clone "https://github.com/agkozak/zsh-z"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/expand-ealias" ] && git clone "https://github.com/seanlaidlaw/expand-ealias.plugin.zsh.git" "expand-ealias"
[ ! -d "$HOME/.oh-my-zsh/custom/zsh-easy-motion" ] && git clone "https://github.com/IngoMeyer441/zsh-easy-motion.git" "$HOME/.oh-my-zsh/custom/zsh-easy-motion"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-command-note" ] && git clone "https://github.com/KKRainbow/zsh-command-note.plugin" "$HOME/.oh-my-zsh/custom/plugins/zsh-command-note"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/careful_rm" ] && git clone "https://github.com/MikeDacre/careful_rm.git"
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-lazyload" ] && git clone "https://github.com/qoomon/zsh-lazyload" "$HOME/.oh-my-zsh/custom/plugins/zsh-lazyload"
[ ! -d "$HOME/.oh-my-zsh/custom/fzf-marks" ] && git clone "https://github.com/urbainvaes/fzf-marks" "$HOME/.oh-my-zsh/custom/fzf-marks"
cd -


# vim-plug installation
[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ] && printf "Downloading vim-plug..." && sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && printf "done.\n\n"

# TPM installation
[ ! -d "$HOME/.tmux/plugins/tpm" ] && printf "Downloading TPM..." && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && printf "done.\n\n"

# setup symlink between system qutebrowser userscripts dir to dotfiles
[ "$(uname)" == "Darwin" ] && [ -d "$dotfiles/qutebrowser/.qutebrowser/userscripts/" ] && [ ! -d "/Users/$USER/Library/Application Support/qutebrowser/userscripts" ] && ln -s "$dotfiles/qutebrowser/.qutebrowser/userscripts/" "/Users/$USER/Library/Application Support/qutebrowser/userscripts"


[ "$(uname)" == "Darwin" ] && ln -s "/Users/$USER/Library/Preferences/qutebrowser/autoconfig.yml" "$dotfiles/qutebrowser/.qutebrowser/autoconfig.yml"

# set keyboard speed to lowest setting for fast arrow key movements
[ "$(uname)" == "Darwin" ] && defaults write NSGlobalDomain KeyRepeat -int 1

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
[ "$(uname)" == "Darwin" ] && mkdir -p "$HOME/Library/Application Support/Übersicht/widgets"
[ "$(uname)" == "Darwin" ] && cd "$HOME/Library/Application Support/Übersicht/widgets" && git clone "https://github.com/seanlaidlaw/simple-bar.git"

# symlink ultisnips so we can track them in dotfiles repo
[ ! -d "$HOME/.config/coc/ultisnips/" ] && printf "Symlinking Ultisnips..." && mkdir -p "$HOME/.config/coc/ultisnips/" && ln -s "$HOME/.dotfiles/vim/ultisnips" "$HOME/.config/coc/ultisnips/" && printf "done.\n\n"


