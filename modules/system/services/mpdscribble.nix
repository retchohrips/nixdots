{config, ...}: {
  services.mpdscribble = {
    enable = true;
    endpoints = {
      "last.fm" = {
        username = "cryptidrabbit";
        passwordFile = config.age.secrets.lastfm-account.path;
      };
    };
  };
}
