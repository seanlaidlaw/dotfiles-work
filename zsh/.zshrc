# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
ZSH_DISABLE_COMPFIX=true
ZSH_AUTOSUGGEST_USE_ASYNC=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="seanys_customized_sorin"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	vi-mode
	git
	zsh-256color
	zsh-autosuggestions
	fast-syntax-highlighting
	history-search-multi-word
	zsh-autopair
	undollar
	you-should-use
	extract
	history-substring-search
	gnu-utils
	careful_rm
	zsh-z
	zsh-lazyload
	fzf-command-bookmarks
	expand-ealias
)

source $ZSH/oh-my-zsh.sh

# load fzf for zsh, and set defaults behavior
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Define global aliases that are expanded anywhere in command line
alias -g G='| grep'
alias -g L='| ${PAGER}'
alias -g P='| pbcopy'
alias -g H='| head'
alias -g V='| ${EDITOR} -'


# bind asc to change first word of command
bindkey -s ,cw '\e0cW'
bindkey -s ,cl '\e0cWll\eA^M'
bindkey -s ,cc '\e0cWc\eA^M'
bindkey -s ,c8 '\e$F/C/*'

# map double escape to fuck command
# src: https://github.com/nvbn/thefuck
bindkey -s '\e\e' 'fuck^M'

# map ctrl-s to show fzf-command-bookmarks
bindkey '^s' fzf-command-bookmark-show-widget

# make jk in shell exit into command mode
bindkey jk vi-cmd-mode

# bind ctrl-q to suspend currently written command to allow
# running another command then putting # back the command
bindkey "^Q" push-input

# read alias and fct from bash
emulate sh -c 'source ~/.bashrc'


# setup easy motion like in vim
# load easy-motion plugin
source $ZSH_CUSTOM/zsh-easy-motion/easy_motion.plugin.zsh

# map vi-easy-motion to space bar
bindkey -M vicmd ' ' vi-easy-motion

# enable c-g for fzf-marks
source $ZSH_CUSTOM/fzf-marks/fzf-marks.plugin.zsh


# QFC SETUP for real-time multi-directories matching
# INSTALL WITH: git clone https://github.com/pindexis/qfc $HOME/.qfc
# This allows c-f to start qfc
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"


# setup thefuck to work
if command -v thefuck 1>/dev/null 2>&1; then
	lazyload fuck -- 'eval $(thefuck --alias)'
fi


# enable KSH globbing
# ex: ls !((succesful_alignments)) gets all files except 'succesful_alignments'
# ex: ls !((succ*)) also gets all files except those that match 'succ*'
setopt kshglob

setopt HIST_IGNORE_DUPS     # Don't record an entry that was just recorded again.
unsetopt HIST_VERIFY        # Disable asking for confirmation before '!!'
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks before recording entry.
unsetopt INC_APPEND_HISTORY # Disable writing to the history file immediately
unsetopt share_history # Disable writing to the history file immediately

# write to history file directly but dont make history avaliable to other shells while they are still active
setopt INC_APPEND_HISTORY_TIME


# ZSH needs to have both HISTSIZE and SAVEHIST
# I want unlimited like in bash but zsh
# so set to a billion
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
