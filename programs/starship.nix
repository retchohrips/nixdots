{
  lib,
  config,
  ...
}: {
  programs.starship = let
    inherit (config.colorScheme) palette;
  in {
    enable = true;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        "[](#${palette.base08})"
        "$os"
        "$hostname"
        "[](bg:#${palette.base09} fg:#${palette.base08})"
        "$directory"
        "[](bg:#${palette.base0A} fg:#${palette.base09})"
        "$git_branch"
        "$git_status"
        "[](bg:#${palette.base0B} fg:#${palette.base0A})"
        "$cmd_duration"
        "[](fg:#${palette.base0B})"
        "$line_break"
        "$character"
      ];

      hostname = {
        ssh_symbol = " ";
        format = "[ $hostname ]($style)";
        style = "bg:#${palette.base08} fg:#${palette.base01}";
      };

      directory = {
        style = "fg:#${palette.base01} bg:#${palette.base09}";
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
        style = "fg:#${palette.base01} bg:#${palette.base0A}";
        format = "[[ $symbol $branch ](fg:#${palette.base01} bg:#${palette.base0A})]($style)";
      };

      git_status = {
        style = "bg:#${palette.base0A}";
        format = "[[($all_status$ahead_behind )](fg:#${palette.base01} bg:#${palette.base0A})]($style)";
      };

      cmd_duration = {
        style = "fg:#${palette.base01} bg:#${palette.base0B}";
        format = "[ $duration]($style)";
      };

      nix_shell = {symbol = " ";};

      os = {
        disabled = false;
        style = "fg:#${palette.base01} bg:#${palette.base08}";
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
    };
  };
}
