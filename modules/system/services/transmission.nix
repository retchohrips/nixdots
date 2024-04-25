{
  pkgs,
  lib,
  config,
  ...
}: {
  services.transmission = lib.mkIf config.modules.system.vpn.enable {
    enable = true;
    settings = {
      rpc-whitelist-enabled = false;
      rpc-bind-address = "0.0.0.0";
      peer-port = 51370;

      anti-brute-force-enabled = true;
      anti-brute-force-threshold = 10;

      blocklist-enabled = true;
      blocklist-url = "https://github.com/Naunter/BT_BlockLists/raw/master/bt_blocklists.gz";

      ratio-limit = "1";
      ratio-limit-enabled = true;
      encryption = 2; # Require encryption
    };
    webHome = pkgs.flood-for-transmission;
  };
  systemd.services.transmission.serviceConfig = {
    RootDirectoryStartOnly = lib.mkForce false;
    RootDirectory = lib.mkForce "";
  };

  systemd.services.transmission.after = ["openvpn-riseup.service"];
  systemd.services.transmission.requires = ["openvpn-riseup.service"];
}
