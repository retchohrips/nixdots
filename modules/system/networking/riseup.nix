{
  pkgs,
  userSettings,
  lib,
  config,
  ...
}: {
  options.modules.system.vpn.enable = lib.mkEnableOption "vpn";
  config = lib.mkIf config.modules.system.vpn.enable {
    services.openvpn.servers = {riseup = {config = ''config /home/${userSettings.username}/.config/openvpn/client/riseup.conf'';};};

    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "riseup-configure";
        runtimeInputs = with pkgs; [curl jq];
        text = "${builtins.readFile ./riseup-configure.sh}";
      })
    ];
  };
}
