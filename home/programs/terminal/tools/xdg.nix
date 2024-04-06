{
  userSettings,
  config,
  ...
}: let
  browser = ["${userSettings.browser}.desktop"];
  file-manager = ["org.gnome.Nautilus.desktop"];
  image-viewer = ["org.gnome.Loupe.desktop"];
  pdf-viewer = ["org.pwmt.zathura.desktop"];
  tg = ["org.telegram.desktop.desktop"];
  archive = ["xarchiver.desktop"];
  audio-player = ["vlc.desktop"];
  video-player = ["vlc.desktop"];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "inode/directory" = file-manager;
    "application/zip" = archive;
    "application/x-tar" = archive;
    "application/x-xz-compressed-tar" = archive;

    "image/*" = image-viewer;
    "audio/*" = audio-player;
    "video/*" = video-player;

    "x-scheme-handler/tg" = tg;

    "application/pdf" = pdf-viewer;
  };
in {
  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = {
      enable = true;

      download = "${config.home.homeDirectory}/Downloads";
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";

      publicShare = "${config.home.homeDirectory}/.local/share/public";
      templates = "${config.home.homeDirectory}/.local/share/templates";

      music = "${config.home.homeDirectory}/Media/Music";
      pictures = "${config.home.homeDirectory}/Media/Pictures";
      videos = "${config.home.homeDirectory}/Media/Videos";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        # XDG_MAIL_DIR = "${config.home.homeDirectory}/Mail";
      };
    };

    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
