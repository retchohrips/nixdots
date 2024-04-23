let
  # users
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKBT0vLxWU+iLJG3AzCDJcAXLrywF6dgnGDcwHmQwjs";

  # hosts
  bundesk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAebvgC9nLUMl+F2jf1pbwtXNchKI1nRsdy1yKXjRfDG";
  pawpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHg5trDBs0WEmy9nid9AfTrfIqeMl7turnSjqscIpSEi";

  # aliases
  personal = [bundesk pawpad];

  # helpers
  mkSecrets = list: list ++ [user];
in {
  "lastfm-account.age".publicKeys = mkSecrets personal;
  "wakatime.age".publicKeys = mkSecrets personal;
  "radarrApiKey.age".publicKeys = mkSecrets personal;
  "sonarrApiKey.age".publicKeys = mkSecrets personal;
}
