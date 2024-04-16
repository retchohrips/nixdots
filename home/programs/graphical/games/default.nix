{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs;
    [
      (lutris.override {
        extraPkgs = pkgs: [
          gnome.zenity
          pixman
          libjpeg
        ];
      })
      prismlauncher # Minecraft
      protontricks
      gnome.zenity
    ]
    ++ (with inputs.nix-gaming.packages.${pkgs.system}; [
      winetricks
    ]);
}
