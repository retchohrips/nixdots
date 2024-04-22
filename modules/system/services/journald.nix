{
  # https://wiki.archlinux.org/title/Systemd/Journal#Persistent_journals
  # limit systemd journal size
  # journals get big really fast
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    RuntimeMaxUse=50M
    SystemMaxFileSize=50M
  '';
}
