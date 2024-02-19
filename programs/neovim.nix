{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {enable = true;};
  xdg.configFile = {
    nvim = {
      source = inputs.nvchad;
      recursive = true;
      onChange = "PATH=$PATH:${pkgs.git}/bin ${pkgs.neovim}/bin/nvim --headless +quitall";
    };

    "nvim/lua/custom" = {
      source = ./nvchad;
      onChange = "PATH=$PATH:${pkgs.git}/bin ${pkgs.neovim}/bin/nvim --headless +quitall";
    };
  };
}
