{pkgs, ...}: {
  # UI library for neovim
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [nui-nvim];
}
