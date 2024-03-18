{pkgs, ...}: {
  virtualisation.oci-containers.containers.tdarr-node = {
    image = "ghcr.io/haveagitgat/tdarr_node";
    environment = {
      serverIP = "cuddlenode";
      serverPort = "8266";
      nodeID = "bundesk";
      nodeIP = "192.168.1.107";
      nodePort = "8267";
      TZ = "America/Chicago";
      PUID = "1000";
      PGID = "1000";
    };
    ports = ["8267:8267"];
    extraOptions = [
      "--network=bridge"
      "--mount=type=bind,source=/mnt/cuddlenode/storage,destination=/storage"
      "--mount=type=bind,source=/mnt/cuddlenode/.config/appdata/tdarrnode/cache,destination=/temp"
    ];
  };
  programs.fuse.userAllowOther = true;
  system.fsPackages = with pkgs; [sshfs];
  fileSystems."/mnt/cuddlenode" = {
    device = "cuddlenode:/home/bunny/";
    fsType = "sshfs";
    options = [
      "allow_other" # non-root access
      "_netdev" # network filesystem

      "reconnect" # handle connection drops
      "delay_connect" # wait for network
      "ServerAliveInterval=15" # keep connections alive
      "IdentityFile=/home/bunny/.ssh/id_ed25519"
    ];
  };
}