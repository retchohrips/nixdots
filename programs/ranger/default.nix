{pkgs, ...}: {

  home.packages = with pkgs; [
    ranger

    # preview dependencies, some are installed already elsewhere, but included for completeness
    atool
    bat
    catdoc
    ebook_tools
    elinks
    exiftool
    feh
    ffmpegthumbnailer
    fontforge
    glow
    highlight
    lynx
    mediainfo
    mupdf
    odt2txt
    p7zip
    pandoc
    poppler_utils
    python3Packages.pygments
    transmission
    unrar
    unzip
    w3m
    xclip
    xlsx2csv
  ];

  xdg.configFile."ranger/rc.conf".source = ./rc.conf;
  xdg.configFile."ranger/scope.sh".source = pkgs.ranger + "/share/doc/ranger/config/scope.sh";
}
