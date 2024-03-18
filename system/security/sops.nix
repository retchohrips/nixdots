{userSettings, ...}: {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${userSettings.username}/.config/sops/age/keys.txt";

    secrets = {
      "lastfm/user" = {};
      "lastfm/pass" = {};
    };
  };
}
