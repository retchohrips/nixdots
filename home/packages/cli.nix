{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-index-db.hmModules.nix-index];
  home.packages = with pkgs; [
    pre-commit
    commitizen
    lazygit
    alejandra # nix formatter
    nil # nix lsp
    unzip
    p7zip
    ripgrep # improved grep
    file
    fd
    just
    libnotify
    ncdu # storage visualization
    sshfs
    trash-cli
    comma # run programs without installing them
    gcc # home-manager must be able to compile c

    # Package management
    nodejs
    cargo
    nodePackages.pnpm
  ];
}
