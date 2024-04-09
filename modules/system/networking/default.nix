{
  systemSettings,
  lib,
  ...
}: let
  inherit (lib) mkForce mkDefault;
in {
  imports = [
    # ./optimise.nix
    ./ssh.nix
  ];
  services = {
    resolved = {
      # enable systemd DNS resolver daemon
      enable = true;

      # this is necessary to get tailscale picking up your headscale instance
      # and allows you to ping connected hosts by hostname
      domains = ["~."];

      # DNSSEC provides to DNS clients (resolvers) origin authentication of DNS data, authenticated denial of existence
      # and data integrity but not availability or confidentiality.
      # this is considered EXPERIMENTAL and UNSTABLE according to upstream
      # PLEASE SEE <https://github.com/systemd/systemd/issues/25676#issuecomment-1634810897>
      # before you decide to set this. I have it set to false as the issue
      # does not inspire confidence in systemd's ability to manage this
      dnssec = "false";

      # additional configuration to be appeneded to systemd-resolved configuration
      extraConfig = ''
        # <https://wiki.archlinux.org/title/Systemd-resolved#DNS_over_TLS>
        # apparently upstream (systemd) recommends this to be false
        # `allow-downgrade` is vulnerable to downgrade attacks
        DNSOverTLS=yes # or allow-downgrade
      '';

      # ideally our fallbackDns should be something more widely available
      # but I do not want my last resort to sell my data to every company available
      # NOTE: DNS fallback is not a recovery DNS
      # See <https://github.com/systemd/systemd/issues/5771#issuecomment-296673115>
      fallbackDns = ["9.9.9.9"];
    };
  };

  networking = {
    hostName = systemSettings.hostname;

    hosts = {
      # Media server accessible by hostname
      "192.168.1.187" = ["cuddlenode"];
    };

    # global dhcp has been deprecated upstream
    # use networkd instead
    # individual interfaces are still managed through dhcp in hardware configurations
    useDHCP = mkForce false;
    useNetworkd = mkForce true;

    # interfaces are assigned names that contain topology information (e.g. wlp3s0)
    # and thus should be consistent across reboots
    # this already defaults to true, we set it in case it changes upstream
    usePredictableInterfaceNames = mkDefault true;

    # dns
    nameservers = [
      # cloudflare, yuck
      # shares data
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"

      # quad9, said to be the best
      # shares *less* data
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved"; # use systemd-resolved for dns
    };
  };

  systemd = {
    network.wait-online.enable = mkForce false;
    services.NetworkManager-wait-online.enable = true;
  };
}
