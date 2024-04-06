let
  # users
  bunny = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKBT0vLxWU+iLJG3AzCDJcAXLrywF6dgnGDcwHmQwjs";

  # hosts
  bundesk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAebvgC9nLUMl+F2jf1pbwtXNchKI1nRsdy1yKXjRfDG";

  # aliases
  personal = [bundesk];

  # helpers
  mkSecrets = list: list ++ [bunny];
in {
  "lastfm-account.age".publicKeys = mkSecrets personal;
  "wakatime.age".publicKeys = mkSecrets personal;
}
