# customized sorin.zsh-theme

MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"
local return_status="%{$bg[red]%}%(?.. ▲ )%{$reset_color%}"

function shortened_pwd() {
	echo "${PWD%/*}" | sed -e 's;\(/.\)[^/]*;\1;g'
}

function bjobs_pend() {
	bjobs -a 2>&1 | sed 's/No\sjob\sfoud//g' | awk 'NF' | grep PEND | wc -l
}
function bjobs_run() {
	bjobs -a 2>&1 | sed 's/No\sjob\sfoud//g' | awk 'NF' | grep RUN | wc -l
}


PROMPT='${return_status} %{$fg[blue]%}$(shortened_pwd)/%{$fg[red]%}%C %{$reset_color%}(%{$fg[yellow]%}$(bjobs_pend) %{$fg[green]%}$(bjobs_run)%{$reset_color%}) %(!.%{$fg_bold[red]%}#.%{$fg_bold[red]%}❯%{$fg_bold[yellow]%}❯%{$fg_bold[green]%}❯)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$bg[red]%}%{$fg[white]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='$(git_prompt_status)$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
