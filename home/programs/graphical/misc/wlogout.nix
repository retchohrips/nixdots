{
  pkgs,
  config,
  ...
}: {
  xdg.configFile = {
    "wlogout/layout".text = ''
      {
        "label" : "lock",
        "action" : "hyprlock",
        "text" : "Lock",
        "keybind" : "l"
      }
      {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
      }
      {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Shutdown",
        "keybind" : "s"
      }
      {
        "label" : "logout",
        "action" : "hyprctl dispatch exit",
        "text" : "Logout",
        "keybind" : "e"
      }
      {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Suspend",
        "keybind" : "u"
      }
      {
        "label" : "hibernate",
        "action" : "systemctl hibernate",
        "text" : "Hibernate",
        "keybind" : "h"
      }
    '';
    "wlogout/style.css".text = with config.lib.stylix.colors; let
      iconPath = "${pkgs.wlogout}/share/wlogout/icons";
    in
      /*
      css
      */
      ''
        window {
          font-family: ${config.stylix.fonts.sansSerif.name};
          font-size: 14pt;
          color: ${withHashtag.base05};
          background-color: alpha(${withHashtag.base00}, 0.5);
        }

        button {
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
          border: none;
          background-color: alpha(${withHashtag.base00}, 0);
          margin: 5px;
          transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
        }

        button:hover {
          background-color: alpha(${withHashtag.base02}, 0.2);
        }

        button:focus {
          background-color: ${withHashtag.base02};
          color: ${withHashtag.base07};
        }

        #lock {
          background-image: image(url("${iconPath}/lock.png"));
        }

        #logout {
          background-image: image(url("${iconPath}/logout.png"));
        }

        #suspend {
          background-image: image(url("${iconPath}/suspend.png"));
        }

        #hibernate {
          background-image: image(url("${iconPath}/hibernate.png"));
        }

        #shutdown {
         background-image: image(url("${iconPath}/shutdown.png"));
        }

        #reboot {
          background-image: image(url("${iconPath}/reboot.png"));
        }

        #firmware {
          background-image: image(url("${iconPath}/reboot.png"));
        }
      '';
  };
}
