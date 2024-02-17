{
  colors,
  userSettings,
  ...
}:
with colors.scheme.catppuccin-mocha;
/*
css
*/
  ''
    * {
      font-family: ${userSettings.font}, monospace;
      font-size: 14px;
      font-weight: bold;
    }

    window {
      background-color: ${crust};
    }

    button {
      background-color: ${base};
      color: ${text};
      border-radius: 20px;
      background-repeat: no-repeat;
      background-position: center;
      background-size: 35%;
    }

    button:focus, button:active, button:hover {
      background-color: ${overlay0};
      outline-style: none;
      border: none;
    }
  ''
