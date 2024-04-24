{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  config = lib.mkIf config.modules.system.arr.enable {
    environment.systemPackages = with pkgs; [recyclarr];

    system.activationScripts.recyclarr_configure = let
      configRoot = "/var/lib/radarr/.config/arr";
      radarrURL = "localhost:7878";
      sonarrURL = "localhost:8989";
    in
      lib.mkIf false ''
        sed=${pkgs.gnused}/bin/sed
        configFile=${configRoot}/recyclarr/recyclarr.yml
        sonarr="${inputs.recyclarr-configs}/sonarr/templates/web-2160p-v4.yml"
        sonarrApiKey=$(cat "${config.age.secrets.sonarrApiKey.path}")
        radarr="${inputs.recyclarr-configs}/radarr/templates/remux-web-2160p.yml"
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
