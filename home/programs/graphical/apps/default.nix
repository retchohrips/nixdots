{userSettings, ...}: {
  imports = [
    ./${userSettings.browser}
    ./discord.nix
  ];
}
