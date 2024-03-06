{
  userSettings,
  pkgs,
  ...
}: {
  # Use Doas instead of sudo
  security.doas = {
    enable = true;
    wheelNeedsPassword = false;
    extraRules = [
      {
        users = ["${userSettings.username}"];
        keepEnv = true;
        persist = true;
      }
    ];
  };
  environment.systemPackages = [
    (pkgs.writeScriptBin "sudo" ''exec doas "$@"'')
  ];
}
