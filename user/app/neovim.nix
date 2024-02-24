{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.packages = with pkgs; [
    deadnix
    statix
    nodePackages_latest.prettier
    stylelint
  ];

  xdg.configFile = {
    nvim = {
      source = inputs.astronvim;
      recursive = true;
      onChange = "PATH=$PATH:${pkgs.git}/bin ${pkgs.neovim}/bin/nvim --headless +quitall";
    };

    "nvim/lua/user" = {
      source = ./astronvim;
      onChange = "PATH=$PATH:${pkgs.git}/bin ${pkgs.neovim}/bin/nvim --headless +quitall";
    };
  };
}
