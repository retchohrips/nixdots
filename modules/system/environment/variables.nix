{userSettings, ...}: {
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";

    PAGER = "less -FR";

    BROWSER = "${userSettings.browser}";
  };
}
