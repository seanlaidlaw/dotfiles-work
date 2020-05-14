# customized sorin.zsh-theme

local return_status="%{$bg[red]%}%(?.. ▲ )%{$reset_color%}"

function shortened_pwd() {
	echo "${PWD%/*}" | sed -e 's;\(/.\)[^/]*;\1;g'
}


PROMPT='${return_status} %{$fg[blue]%}$(shortened_pwd)/%{$fg[red]%}%C%{$reset_color%} %(!.%{$fg_bold[red]%}#.%{$fg_bold[red]%}❯%{$fg_bold[yellow]%}❯%{$fg_bold[green]%}❯)%{$reset_color%} '

