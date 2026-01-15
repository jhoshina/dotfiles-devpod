#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

if [ ! -d "$HOME/.config" ]; then
  mkdir $HOME/.config
fi

if ! command -v mise >/dev/null 2>&1; then
  curl https://mise.run | sh
fi

# stow -v mise
mkdir -p "$HOME/.config/mise"
ln -sf $SCRIPT_DIR/mise/.config/mise/config.toml ~/.config/mise/config.toml
mise install
echo "eval \"\$($HOME/.local/bin/mise activate zsh)\"" >> ~/.zshrc

# stow -v zsh
# ln -sf zsh/.zshrc ~/.zshrc
# ln -sf zsh/.zshenv ~/.zshenv
echo "export EDITOR=nvim" >> ~/.zshenv
echo "export PAGER=bat" >> ~/.zshenv

# stow -v nvim
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi
ln -sf "$SCRIPT_DIR/nvim/.config/nvim/lua/plugins/colorscheme.lua" ~/.config/nvim/lua/plugins/colorscheme.lua
ln -sf "$SCRIPT_DIR/nvim/.config/nvim/lua/plugins/dap.lua" ~/.config/nvim/lua/plugins/dap.lua
ln -sf "$SCRIPT_DIR/nvim/.config/nvim/lua/plugins/neotest.lua" ~/.config/nvim/lua/plugins/neotest.lua
ln -sf "$SCRIPT_DIR/nvim/.config/nvim/lua/config/options.lua" ~/.config/nvim/lua/config/options.lua

# stow -v tmux
