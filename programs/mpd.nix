{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [mpd mpc-cli];

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/Music/Playlists";
    dataDir = "${config.home.homeDirectory}/.config/mpd";
    extraConfig = ''
      auto_update "yes"
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
      audio_output {
      	type                "fifo"
      	name                "Visualizer"
      	format              "44100:16:2"
      	path                "/tmp/mpd.fifo"
      }
    '';
  };
}
