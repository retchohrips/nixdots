{
  config,
  pkgs,
  ...
}: {
  imports = [./settings.nix ./binds.nix];
  programs.ncmpcpp = {
    enable = true;
    package =
      (pkgs.ncmpcpp.override
        {
          visualizerSupport = true;
        })
      .overrideAttrs (oldAttrs: {
        patches = [
          (pkgs.fetchpatch {
            # Add embedded lyrics fetching
            url = "https://github.com/ncmpcpp/ncmpcpp/pull/482.patch";
            hash = "sha256-d+DkoUxm32vljxdrUStXfjinN3xJjzDlpNmMA3GyRTE=";
          })
        ];
      });
    mpdMusicDir = config.services.mpd.musicDirectory;
  };
}
