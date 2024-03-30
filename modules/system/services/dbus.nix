{pkgs, ...}: {
  services.dbus = {
    enable = true;
    packages = with pkgs; [dconf gcr udisks2];

    # Use the faster dbus-broker instead of the classic dbus-daemon
    # this setting is experimental, but seems to break nothing
    implementation = "broker";
  };
}
