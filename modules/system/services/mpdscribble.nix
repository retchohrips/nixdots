{config, ...}: {
  services.mpdscribble = {
    enable = true;
    endpoints = {
      "last.fm" = {
        username = "cryptidrabbit";
        passwordFile = config.sops.secrets."lastfm/pass".path;
      };
    };
  };
}
