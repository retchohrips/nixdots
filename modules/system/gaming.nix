{pkgs, ...}: {
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;

    # Compatibility tools to install
    # For the accepted format (and the reason behind)
    # the "compattool" attribute, see:
    # <https://github.com/NixOS/nixpkgs/pull/296009>
    extraCompatPackages = [
      pkgs.proton-ge-bin.steamcompattool
    ];
  };
}
