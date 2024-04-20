{
  pkgs,
  # userSettings,
  ...
}: {
  # for some reason the config works just fine, but the systemd service does not
  # services.openvpn.servers = {riseup = {config = ''config /home/${userSettings.username}/openvpn/client/riseup.conf'';};};

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "riseup-configure";
      runtimeInputs = with pkgs; [curl jq];
      text = "${builtins.readFile ./riseup-configure.sh}";
    })
  ];
}
