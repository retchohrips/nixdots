{
  userSettings,
  pkgs,
  ...
}: {
  programs.nh = {
    # "yet-another-nix-helper"
    enable = true;
    package = pkgs.nh;
    clean.enable = true;
    flake = "/home/${userSettings.username}/.dotfiles";
  };
}
