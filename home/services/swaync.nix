{
  lib,
  osConfig,
  config,
  ...
}: {
  services.swaync = lib.mkIf osConfig.programs.hyprland.enable {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      control-center-margin-top = 2;
      control-center-margin-bottom = 2;
      control-center-margin-right = 1;
      control-center-margin-left = 0;
      notification-icon-size = 48;
      notification-body-image-height = 160;
      notification-body-image-width = 200;
      timeout = 6;
      timeout-low = 4;
      timeout-critical = 0;
      fit-to-screen = true;
      control-center-width = 380;
      control-center-height = 860;
      notification-window-width = 400;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;
      widgets = [
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = " 󰎟 ";
        };
        dnd = {text = "Do not disturb";};
        mpris = {
          image-size = 96;
          image-radius = 6;
        };
      };
    };

    style = with config.lib.stylix.colors; ''
      * {
        color: ${withHashtag.base05};
        all: unset;
        font-family: ${config.stylix.fonts.sansSerif.name};
        transition: 200ms;
      }

      /* NOTIFICATIONS THEMSELVES */

      .notification-row {
        outline: none;
        margin: 0;
        padding: 0px;
      }

      .floating-notifications.background .notification-row .notification-background {
        background: rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, .55);
        box-shadow: 0 2px 8px 0 ${withHashtag.base00};
        border: 1px solid ${withHashtag.base0D};
        border-radius: 12px;
        margin: 16px;
        padding: 0;
      }

      .floating-notifications.background .notification-row .notification-background .notification {
        padding: 6px;
        border-radius: 12px;
      }

      .floating-notifications.background .notification-row .notification-background .notification.critical {
        border: 2px solid ${withHashtag.base08};
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content {
        margin: 14px;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: 8px;
        background-color: ${withHashtag.base02};
        margin: 6px;
        border: 1px solid transparent;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        background-color: ${withHashtag.base03};
        border: 1px solid ${withHashtag.base0D};
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        background-color: ${withHashtag.base0D};
        color: ${withHashtag.base00};
      }

      .image {
        margin: 10px 20px 10px 0px;
      }

      .summary {
        font-weight: 800;
        font-size: 1rem;
      }

      .body {
        font-size: 0.8rem;
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        margin: 6px;
        padding: 2px;
        border-radius: 6px;
        background-color: transparent;
        border: 1px solid transparent;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:hover {
        background-color: ${withHashtag.base0D};
      }

      .floating-notifications.background .notification-row .notification-background .close-button:active {
        background-color: ${withHashtag.base0D};
        color: ${withHashtag.base00};
      }

      .notification.critical progress {
        background-color: ${withHashtag.base0D};
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: ${withHashtag.base0D};
      }

      /* SIDEBAR STUFF */

      /* Avoid 'annoying' background */
      .blank-window {
        background: transparent;
      }

      /* Control Center */
      .control-center {
        background: rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, .55);
        border-radius: 12px;
        border: 1px solid ${withHashtag.base0D};
        box-shadow: 0 2px 8px 0 ${withHashtag.base00};
        margin: 18px;
        padding: 12px;
      }

      /* Notifications  */
      .control-center .notification-row .notification-background,
      .control-center .notification-row .notification-background .notification.critical {
        background-color: rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, .4);
        border-radius: 10px;
        margin: 4px 0px;
        padding: 4px;
      }

      .control-center .notification-row .notification-background .notification.critical {
        color: ${withHashtag.base08};
      }

      .control-center .notification-row .notification-background .notification .notification-content {
        margin: 4px;
        padding: 8px 6px 2px 2px;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
        background: ${withHashtag.base02};
        color: ${withHashtag.base05};
        border-radius: 8px;
        margin: 6px;
        border: 2px solid transparent;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        color: ${withHashtag.base00};
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        background-color: ${withHashtag.base0D};
        color: ${withHashtag.base00};
      }

      /* Buttons */

      .control-center .notification-row .notification-background .close-button {
        border: 1px solid transparent;
        background: transparent;
        border-radius: 6px;
        color: ${withHashtag.base0D};
        margin: 0px;
        padding: 4px;
      }

      .control-center .notification-row .notification-background .close-button:hover {
        background-color: ${withHashtag.base00};
        border: 1px solid ${withHashtag.base0D};
      }

      .control-center .notification-row .notification-background .close-button:active {
        background-color: ${withHashtag.base0D};
        color: ${withHashtag.base00};
      }

      progressbar,
      progress,
      trough {
        border-radius: 12px;
      }

      progressbar {
        background-color: rgba(255,255,255,.1);
      }

      /* Notifications expanded-group */

      .notification-group {
        margin: 2px 8px 2px 8px;

      }
      .notification-group-headers {
        font-weight: bold;
        font-size: 1.25rem;
        color: ${withHashtag.base05};
        letter-spacing: 2px;
        margin-bottom: 16px;
      }

      .notification-group-icon {
        color: ${withHashtag.base05};
      }

      .notification-group-collapse-button,
      .notification-group-close-all-button {
        background: transparent;
        margin: 4px;
        border: 2px solid transparent;
        border-radius: 8px;
        padding: 4px;
      }

      .notification-group-collapse-button:hover,
      .notification-group-close-all-button:hover {
        background: rgba(${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}, .2);
        border: 2px solid ${withHashtag.base05};
      }

      /* Widgets */

      /* Notification clear button */
      .widget-title {
        font-size: 1.2em;
        margin: 2px;
      }

      .widget-title button {
        border-radius: 10px;
        padding: 4px 16px;
        border: 2px solid ${withHashtag.base0D};
      }

      .widget-title button:hover {
        background-color: rgba(${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}, .2);
        border: 2px solid ${withHashtag.base0D};
      }

      .widget-title button:active {
        background-color: ${withHashtag.base0D};
        color: ${withHashtag.base00};
      }

        /* Do not disturb */
      .widget-dnd {
        margin: 8px 2px;
        font-size: 1.2rem;
      }

      .widget-dnd > switch {
        font-size: initial;
        border-radius: 8px;
        border: 2px solid ${withHashtag.base0D};
        box-shadow: none;
      }

      .widget-dnd > switch:hover {
        background: rgba(${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}, .2);
      }

      .widget-dnd > switch:checked {
        background: ${withHashtag.base0D};
      }

      .widget-dnd > switch:checked:hover {
        background: rgba(${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b}, .8);
      }

      .widget-dnd > switch slider {
        background: ${withHashtag.base05};
        border-radius: 6px;
      }

      /* Buttons menu */
      .widget-buttons-grid {
        font-size: x-large;
        padding: 6px 2px;
        margin: 6px;
        border-radius: 12px;
        background: rgba(${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b}, .2);
      }

      .widget-buttons-grid>flowbox>flowboxchild>button {
        margin: 4px 10px;
        padding: 6px 12px;
        background: transparent;
        border-radius: 8px;
        border: 2px solid transparent;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button:hover {
        background: rgba(${base02-rgb-r}, ${base02-rgb-g}, ${base02-rgb-b}, .6);
      }

      /* Music player */
      .widget-mpris {
          background: rgba(${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b}, .2);
          border-radius: 16px;
          color: ${withHashtag.base05};
          padding: 6px;
          margin:  20px 6px;
      }

      .widget-mpris button {
        color: rgba(${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}, .6);
        border-radius: 6px;
      }

      .widget-mpris button:hover {
        color: ${withHashtag.base05};
      }

        /* NOTE: Background need *opacity 1* otherwise will turn into the album art blurred  */
      .widget-mpris-player {
          background: ${withHashtag.base0D};
          padding: 6px 10px;
          margin: 10px;
          border-radius: 14px;
      }

      .widget-mpris-album-art {
        border-radius: 16px;
      }

      .widget-mpris-title {
          font-weight: 700;
          font-size: 1rem;
      }

      .widget-mpris-subtitle {
          font-weight: 500;
          font-size: 0.8rem;
      }


      /* Volume */
      .widget-volume {
        background: ${withHashtag.base02};
        color: ${withHashtag.base00};
        padding: 4px;
        margin: 6px;
        border-radius: 6px;
      }
    '';
  };
}
