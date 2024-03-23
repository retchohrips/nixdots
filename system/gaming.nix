{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  environment.systemPackages = with pkgs; [gamescope];
  hardware.opengl.driSupport32Bit = true;

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [proton-ge-bin];
    gamescopeSession.enable = true;
  };
  services.pipewire.lowLatency = {enable = true;};
}
