{
  userSettings,
  lib,
  ...
}: {
  imports = [
    ./modules
    ./packages
    ./programs
    ./services
    ./theme/stylix.nix
  ];

  home = {
    # Do not change the below value. It determines the Home Manager release
    # that this config is compatible with. Do not change it,
    # even when Home Manager updates.
    stateVersion = "23.11";

    inherit (userSettings) username;
    homeDirectory = "/home/" + userSettings.username;
  };

  manual = {
    # save space by not making docs that i never read anyway
    html.enable = false;
    json.enable = false;
    manpages.enable = true;
  };

  programs.home-manager.enable = true; # Let HM manage itself

  # reload systemd units when changing configs
  systemd.user.startServices = lib.mkDefault "sd-switch";
}
