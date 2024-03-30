{
  # https://wiki.archlinux.org/title/Systemd/Journal#Persistent_journals
  # limit systemd journal size
  # journals get big really fast, and on desktops they are not audited often
  # on servers, however, they are important for both security and stability
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    RuntimeMaxUse=50M
    SystemMaxFileSize=50M
  '';
}
