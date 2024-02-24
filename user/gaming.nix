{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs;
    [lutris]
    ++ (with inputs.nix-gaming.packages.${pkgs.system}; [wine-ge]);
}
