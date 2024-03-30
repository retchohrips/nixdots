{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./options.nix
    ./keymaps.nix

    ./plugins
  ];

  stylix.targets.nixvim = {
    transparent_bg.main = true;
    transparent_bg.sign_column = true;
  };

  programs.nixvim = {enable = true;};
}
