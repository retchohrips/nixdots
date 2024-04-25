{
  userSettings,
  pkgs,
  ...
}: {
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "wheel"];
  };
}
