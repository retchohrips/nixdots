{
  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    openFirewall = true; # automatically allow ports
    startWhenNeeded = true;
  };
}
