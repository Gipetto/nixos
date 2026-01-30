export ZSH_DISABLE_COMPFIX=true
zstyle ':omz:update' mode reminder

# Path updates
path=(
  "$HOME/.local/bin"
  $path
)
typeset -U PATH

# OS detection
if [[ "$OSTYPE" == "darwin"* ]]; then
    export IS_MAC=1
    export PATH="$(brew --prefix)/opt/libpq/bin:$HOME/.local/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/sqlite/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/sqlite/include"
    export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c@77/lib/pkgconfig"
    export HOMEBREW_CASK_OPTS="--fontdir=/Library/Fonts"

    # macOS-only completions/plugins
    if (( $+commands[zsh-autosuggestions] )); then
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi
    if (( $+commands[zsh-syntax-highlighting] )); then
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
fi

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export IS_LINUX=1
    export PATH="$HOME/.local/bin:$PATH"
    if command -v lspci >/dev/null 2>&1 && lspci | grep -q "NVIDIA"; then
        export WLR_RENDERER=vulkan
    fi
fi

# Tools requiring eval
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi

if (( $+commands[mise] )); then
    eval "$(mise activate zsh)"
    eval "$(mise completion zsh)"
fi

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

if (( $+commands[eza] )); then
  alias ls="eza --icons=always"
fi

# History settings (must be after OMZ)
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"
setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE EXTENDED_HISTORY
unsetopt HIST_EXPIRE_DUPS_FIRST SHARE_HISTORY

# Maybe obsolete by now...
export NODE_OPTIONS="--dns-result-order=ipv4first"

# Load environment specific to the local machine
if test -f ~/.zshrc.local; then
. ~/.zshrc.local
fi
