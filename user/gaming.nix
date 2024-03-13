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
    ]
    ++ (with inputs.nix-gaming.packages.${pkgs.system}; [
      wine-ge
      winetricks
    ]);
}
