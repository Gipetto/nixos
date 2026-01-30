# vim:ft=zsh ts=2 sw=2 sts=2

# Dates:
# https://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/

# Colors:
# for code in {000..255}; do print -P -- "$code: %F{$code}Color%f"; done

prompt_context() {
    local user=`whoami`
    local hostname=`hostname`

    local context=

    if [[ -n "$SSH_CONNECTION" ]]; then
        context="$user@$hostname"
    fi

    if [[ -n "$context" ]]; then
        print "%(!.%{%F{yellow}%}.)$context "
    fi
}

FORCE_RUN_VCS_INFO=1

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
#ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
#ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{●%G%}"
#ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
#ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚%G%}"
#ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[blue]%}%{-%G%}"
#ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
#ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}%{…%G%}"
#ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[blue]%}%{⚑%G%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"
#ZSH_THEME_GIT_PROMPT_UPSTREAM_SEPARATOR="->"

prompt_git() {
    echo "$(git_super_status)"
}

precmd_vcs_info() {
    RPROMPT=
}

precmd_functions+=( precmd_vcs_info )
setopt prompt_subst


PROMPT='%F{245}%D{%b %d} %D{%H:%M:%S} 〉%f$(prompt_context)%{$fg[cyan]%}%~%  〉%{$reset_color%}$(prompt_git)${reset_color}
%B$%b '
