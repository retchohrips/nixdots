{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs;
    [
      lutris
      prismlauncher # Minecraft
    ]
    ++ (with inputs.nix-gaming.packages.${pkgs.system}; [wine-ge]);
}
