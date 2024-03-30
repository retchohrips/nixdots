{
  userSettings,
  lib,
  config,
  ...
}: {
  imports = [
    ./tdarr.nix
  ];

  config = lib.mkIf config.modules.system.virtualization.docker.enable {
    virtualisation = {
      docker.enable = true;
      oci-containers.backend = "docker";
    };
    users.extraGroups.docker.members = [" ${userSettings.username}"];
  };
}
