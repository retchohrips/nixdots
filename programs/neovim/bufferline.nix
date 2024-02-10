{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins.bufferline = {
    enable = true;
    mode = "buffers";
    diagnostics = "nvim_lsp";
    indicator.style = null;
  };
}
