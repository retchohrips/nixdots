{
  pkgs,
  lib,
  config,
  inputs,
  userSettings,
  ...
}: {
  config = lib.mkIf config.modules.system.arr.enable {
    virtualisation.oci-containers.containers.recyclarr = {
      autoStart = true;
      environment = {
        CRON_SCHEDULE = "@daily";
      };
      image = "ghcr.io/recyclarr/recyclarr:6.0.2";
      volumes = ["/home/${userSettings.username}/.config/recyclarr/recyclarr.yml:/config"];
    };

    system.activationScripts.recyclarr_configure = let
      configRoot = "/home/${userSettings.username}/.config";
      radarrURL = "localhost:7878";
      sonarrURL = "localhost:8989";
    in ''
      sed=${pkgs.gnused}/bin/sed
      configFile=${configRoot}/recyclarr/recyclarr.yml
      sonarr="${inputs.recyclarr-configs}/sonarr/templates/web-1080p-v4.yml"
      sonarrApiKey=$(cat "${config.age.secrets.sonarrApiKey.path}")
      radarr="${inputs.recyclarr-configs}/radarr/templates/remux-web-1080p.yml"
      radarrApiKey=$(cat "${config.age.secrets.radarrApiKey.path}")

      cat $sonarr > $configFile
      $sed -i"" "s/Put your API key here/$sonarrApiKey/g" $configFile
      $sed -i"" "s/Put your Sonarr URL here/https:\/\/${sonarrURL}/g" $configFile

      printf "\n" >> ${configRoot}/recyclarr/recyclarr.yml
      cat $radarr >> ${configRoot}/recyclarr/recyclarr.yml
      $sed -i"" "s/Put your API key here/$radarrApiKey/g" $configFile
      $sed -i"" "s/Put your Radarr URL here/https:\/\/${radarrURL}/g" $configFile
    '';
  };
}
