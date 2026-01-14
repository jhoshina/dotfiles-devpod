bindkey -e  # Use Emacs keybindings

# Shell options
setopt auto_cd       # Automatically cd into directories by typing the name
setopt auto_pushd    # Push directory onto stack when using cd
setopt correct       # Suggest corrections for mistyped commands
setopt list_packed   # Show completion list in a compact horizontal layout

# History settings
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
function history-all { history 1 }
setopt extended_history
setopt share_history

# Completion system
autoload -Uz compinit
compinit

# Setup colorized 'ls' command depending on availability and platform
if command -v lsd >/dev/null 2>&1; then
  alias ls='lsd'
else
  case "$OSTYPE" in
    darwin*)  alias ls='ls -G' ;;            # macOS: -G enables color
    linux*)   alias ls='ls --color=auto' ;;  # Linux: --color=auto enables color
    *)        alias ls='ls' ;;               # fallback
  esac
fi

# fzf integration
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# zoxide integration
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

