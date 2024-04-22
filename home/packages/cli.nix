{pkgs, ...}: {
  home.packages = with pkgs; [
    pre-commit
    commitizen # conventional commits cli
    lazygit
    alejandra # nix formatter
    nil # nix lsp
    unzip
    p7zip
    ripgrep # better grep
    file
    fd # better find
    just # justfiles
    libnotify
    ncdu # storage visualization
    sshfs # mount filesystem over ssh
    trash-cli
    gcc # home-manager must be able to compile c

    # Package management
    nodejs
    cargo
    nodePackages.pnpm
  ];
}
