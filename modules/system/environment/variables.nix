{
  config,
  lib,
  ...
}: let
  acceptedTypes = ["desktop" "laptop"];
in {
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";

    PAGER = "less -FR";

    BROWSER = lib.mkIf (builtins.elem config.modules.device.type acceptedTypes) "firefox";
  };
}
