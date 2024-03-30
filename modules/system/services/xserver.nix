{pkgs, ...}: {
  services.xserver = {
    enable = true;

    # do not install xterm
    excludePackages = with pkgs; [xterm];
  };
}
