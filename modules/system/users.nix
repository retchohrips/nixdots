{
  userSettings,
  pkgs,
  lib,
  config,
  ...
}: {
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "wheel"] ++ lib.optionals config.modules.system.virtualization.docker.enable ["docker"];
  };
}
