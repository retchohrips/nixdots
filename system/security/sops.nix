{
  userSettings,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [sops age];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${userSettings.username}/.config/sops/age/keys.txt";

    secrets = {
      "lastfm/pass" = {};
    };
  };
}
