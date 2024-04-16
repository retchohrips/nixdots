{pkgs, ...}: {
  home.packages = with pkgs; [
    pre-commit
    commitizen
    lazygit
    alejandra # nix formatter
    nil # nix lsp
    unzip
    p7zip
    ripgrep
    file
    fd
    fzf
    just
    libnotify
    ncdu
    sshfs
    trash-cli
    gcc # home-manager must be able to compile c

    # Package management
    nodejs
    cargo
    nodePackages.pnpm
  ];
}
