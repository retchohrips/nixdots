{
  userSettings,
  systemSettings,
  ...
}: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/${userSettings.username}";
    user = "${userSettings.username}";
    settings = {
      folders = {
        Music = {
          enable = true;
          devices = ["S23"];
          label = "Music";
          id = "jfvxq-2lb67";
          path =
            if (systemSettings.hostname == "bundesk")
            then "/mnt/Cass/Music"
            else "/home/${userSettings.username}/Media/Music";
        };
        Obsidian = {
          enable = true;
          devices = ["S23"];
          label = "Obsidian";
          id = "pnweh-uhtt2";
          path = "/home/${userSettings.username}/Documents/Obsidian";
        };
      };
      options = {
        relaysEnabled = true;
        urAccepted = -1;
      };
      devices = {
        S23 = {
          id = "RP3YA5P-EXN4AAG-JAMUDCL-C7GTHE4-SSTGPKC-LSD6UJH-WIBQSVM-K5IXFAN";
        };
      };
    };
  };
}
