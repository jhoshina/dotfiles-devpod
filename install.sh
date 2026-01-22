#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

if [ ! -d "$HOME/.config" ]; then
  mkdir $HOME/.config
fi

if ! command -v mise >/dev/null 2>&1; then
  curl https://mise.run | sh
fi

# mise
mkdir -p "$HOME/.config/mise"
ln -sf "$SCRIPT_DIR/mise/.config/mise/config.toml" "$HOME/.config/mise/config.toml"
mise install
# echo "eval \"\$($HOME/.local/bin/mise activate zsh)\"" >> "$HOME/.zshrc"

# zsh
# ln -sf "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$SCRIPT_DIR/zsh/.zshenv" "$HOME/.zshenv"

# nvim
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
fi
ln -sf "$SCRIPT_DIR/nvim/.config/nvim/lua/config/options.lua" "$HOME/.config/nvim/lua/config/options.lua"
ln -sf "$SCRIPT_DIR/nvim/.config/nvim/lua/plugins/colorscheme.lua" "$HOME/.config/nvim/lua/plugins/colorscheme.lua"
# ln -sf "$SCRIPT_DIR/nvim/.config/nvim/lua/plugins/dap.lua" "$HOME/.config/nvim/lua/plugins/dap.lua"
# ln -sf "$SCRIPT_DIR/nvim/.config/nvim/lua/plugins/neotest.lua" "$HOME/.config/nvim/lua/plugins/neotest.lua"

# tmux
mkdir -p "$HOME/.config/tmux"
mkdir -p "$HOME/.local/share/tmux/plugins"
git clone https://github.com/tmux-plugins/tpm "$HOME/.local/share/tmux/plugins/tpm"

