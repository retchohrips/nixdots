{
  config,
  inputs,
  userSettings,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (userSettings) username;

  homeDir = config.home-manager.users.${username}.home.homeDirectory;

  mkSecret = enableCondition: {
    file,
    owner ? "root",
    group ? "root",
    mode ? "400",
  }:
    mkIf enableCondition {
      # Requiring the flake to live in ".dotfiles" is probably not the best decision, but I don't understand `self`
      file = "/${homeDir}/.dotfiles/secrets/${file}.age";
      inherit group owner mode;
    };

  mkSecretWithPath = enableCondition: {
    file,
    path,
    owner ? "root",
    group ? "root",
    mode ? "400",
  }:
    mkIf enableCondition {
      file = "/${homeDir}/.dotfiles/secrets/${file}.age";
      inherit path group owner mode;
    };
in {
  imports = [inputs.agenix.nixosModules.default];
  environment.systemPackages = [inputs.agenix.packages.${pkgs.system}.default];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/${homeDir}/.ssh/id_ed25519"
  ];

  age.secrets = {
    lastfm-account = mkSecret true {file = "lastfm-account";};
    wakatime = mkSecretWithPath true {
      file = "wakatime";
      path = homeDir + ".wakatime.cfg";
      owner = username;
      group = "users";
      mode = "777";
    };
  };
}
