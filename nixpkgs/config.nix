{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-tools";
      paths = [
        neovim
        tmux
        starship
        fd
        lsd
        ripgrep
        lazygit
        zsh-completions
        zsh-autosuggestions
        gemini-cli
      ];
    };
  };
}

