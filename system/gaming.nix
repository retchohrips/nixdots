{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  environment.systemPackages = with pkgs; [winetricks gamescope];
  hardware.opengl.driSupport32Bit = true;
  # environment.systemPackages = with pkgs; [gamemode];
  # programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = [inputs.nix-gaming.packages.${pkgs.system}.proton-ge];
    gamescopeSession.enable = true;
  };
  services.pipewire.lowLatency = {enable = true;};
}
