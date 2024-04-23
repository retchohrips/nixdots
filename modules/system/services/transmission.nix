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
