{
  userSettings,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.modules.system.virtualization.docker.enable {
    virtualisation = {
      docker.enable = true;
      oci-containers.backend = "docker";
    };
    users.extraGroups.docker.members = [" ${userSettings.username}"];
  };
}
