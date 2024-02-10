{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    autoCleanAfterSessionRestore = true;
  };
}
