{
  pkgs,
  astronvim,
  ...
}: {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  xdg.configFile = {
    astronvim = {
      onChange = "PATH=$PATH:${pkgs.git}/bin ${pkgs.neovim}/bin/nvim --headless +quitall";
      source = ./astronvim;
    };

    nvim = {
      onChange = "PATH=$PATH:${pkgs.git}/bin ${pkgs.neovim}/bin/nvim --headless +quitall";
      source = astronvim;
    };
  };
}
