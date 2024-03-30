{pkgs, ...}: {
  # Packages that should always be installed
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    lshw
    rsync
    man-pages
  ];
}
