{pkgs, ...}: {
  xdg.configFile."ranger/rc.conf".source = ./rc.conf;
  xdg.configFile."ranger/scope.sh".source = pkgs.ranger + "/share/doc/ranger/config/scope.sh";
}
