# vim:ft=zsh ts=2 sw=2 sts=2
# Wookiee theme for oh-my-zsh
# Managed by chezmoi

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
