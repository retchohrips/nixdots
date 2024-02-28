{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.steamCompat
  ];
  hardware.opengl.driSupport32Bit = true;
  environment.systemPackages = with pkgs; [gamemode prismlauncher];
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = [inputs.nix-gaming.packages.${pkgs.system}.proton-ge];
  };
  # services.pipewire.lowLatency = {enable = true;};
}
