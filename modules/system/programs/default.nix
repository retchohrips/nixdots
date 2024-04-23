{
  imports = [./nano.nix ./nh.nix];
  programs = {
    less.enable = true;
    fish.enable = true; # home-manager wants this to be set everywhere
    thefuck.enable = true; # type "fuck" to fix commands that made you go "FUCK"
    bandwhich.enable = true; # show network usage
    dconf.enable = true; # registry for linux from gnome
    seahorse.enable = true; # gnome's keyring manager
  };
}
