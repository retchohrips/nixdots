{lib, ...}: {
  programs.starship.enable = true;
  programs.starship.enableTransience = true;
  programs.starship.settings = {
    palette = "catppuccin";

    format = lib.concatStrings [
      "[](maroon)"
      "$os"
      "$hostname"
      "[](bg:peach fg:maroon)"
      "$directory"
      "[](bg:yellow fg:peach)"
      "$git_branch"
      "$git_status"
      "[](bg:green fg:yellow)"
      "$cmd_duration"
      "[](fg:green)"
      "$line_break"
      "$character"
    ];

    hostname = {
      ssh_symbol = " ";
      format = "[ $hostname ]($style)";
      style = "bg:maroon fg:crust";
    };

    directory = {
      style = "fg:crust bg:peach";
      fish_style_pwd_dir_length = 1;
      truncation_length = 5;
      format = "[ $path ]($style)";
    };

    directory.substitutions = {
      "Documents" = "󰈙 ";
      "Downloads" = " ";
      "Music" = "󰝚 ";
      "Pictures" = " ";
    };

    git_branch = {
      symbol = "󰘬";
      style = "fg:crust bg:yellow";
      format = "[[ $symbol $branch ](fg:crust bg:yellow)]($style)";
    };

    git_status = {
      style = "bg:yellow";
      format = "[[($all_status$ahead_behind )](fg:fg:crust bg:yellow)]($style)";
    };

    cmd_duration = {
      style = "fg:crust bg:green";
      format = "[ $duration]($style)";
    };

    nix_shell = {
      symbol = " ";
    };

    os = {
      disabled = false;
      style = "fg:crust bg:maroon";
    };

    os.symbols = {
      Alpaquita = " ";
      Alpine = " ";
      Amazon = " ";
      Android = " ";
      Arch = " ";
      Artix = " ";
      CentOS = " ";
      Debian = " ";
      DragonFly = " ";
      Emscripten = " ";
      EndeavourOS = " ";
      Fedora = " ";
      FreeBSD = " ";
      Garuda = "󰛓 ";
      Gentoo = " ";
      HardenedBSD = "󰞌 ";
      Illumos = "󰈸 ";
      Linux = " ";
      Mabox = " ";
      Macos = " ";
      Manjaro = " ";
      Mariner = " ";
      MidnightBSD = " ";
      Mint = " ";
      NetBSD = " ";
      NixOS = " ";
      OpenBSD = "󰈺 ";
      openSUSE = " ";
      OracleLinux = "󰌷 ";
      Pop = " ";
      Raspbian = " ";
      Redhat = " ";
      RedHatEnterprise = " ";
      Redox = "󰀘 ";
      Solus = "󰠳 ";
      SUSE = " ";
      Ubuntu = " ";
      Unknown = " ";
      Windows = "󰍲 ";
    };

    palettes.catppuccin = {
      rosewater = "#f5e0dc";
      flamingo = "#f2cdcd";
      pink = "#f5c2e7";
      mauve = "#cba6f7";
      red = "#f38ba8";
      maroon = "#eba0ac";
      peach = "#fab387";
      yellow = "#f9e2af";
      green = "#a6e3a1";
      teal = "#94e2d5";
      sky = "#89dceb";
      sapphire = "#74c7ec";
      blue = "#89b4fa";
      lavender = "#b4befe";
      text = "#cdd6f4";
      subtext1 = "#bac2de";
      subtext0 = "#a6adc8";
      overlay2 = "#9399b2";
      overlay1 = "#7f849c";
      overlay0 = "#6c7086";
      surface2 = "#585b70";
      surface1 = "#45475a";
      surface0 = "#313244";
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";
    };
  };
}
