{
  userSettings,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  environment.systemPackages = with pkgs; [sops age];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${userSettings.username}/.config/sops/age/keys.txt";

    secrets = {
      "lastfm/pass" = {};

      wakatime = {
        path = "/home/${userSettings.username}/.wakatime.cfg";
        mode = "0777";
      };
    };
  };
}
