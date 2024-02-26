{
  lib,
  config,
  ...
}:
with config.lib.stylix.colors; {
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        "[](${withHashtag.base08})"
        "$os"
        "$hostname"
        "[](bg:${withHashtag.base09} fg:${withHashtag.base08})"
        "$directory"
        "[](bg:${withHashtag.base0A} fg:${withHashtag.base09})"
        "$git_branch"
        "$git_status"
        "[](bg:${withHashtag.base0B} fg:${withHashtag.base0A})"
        "$cmd_duration"
        "[](fg:${withHashtag.base0B})"
        "$line_break"
        "$character"
      ];

      hostname = {
        ssh_symbol = " ";
        format = "[ $hostname ]($style)";
        style = "bg:${withHashtag.base08} fg:${withHashtag.base01}";
      };

      directory = {
        style = "fg:${withHashtag.base01} bg:${withHashtag.base09}";
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
        style = "fg:${withHashtag.base01} bg:${withHashtag.base0A}";
        format = "[[ $symbol $branch ](fg:${withHashtag.base01} bg:${withHashtag.base0A})]($style)";
      };

      git_status = {
        style = "bg:${withHashtag.base0A}";
        format = "[[($all_status$ahead_behind )](fg:${withHashtag.base01} bg:${withHashtag.base0A})]($style)";
      };

      cmd_duration = {
        style = "fg:${withHashtag.base01} bg:${withHashtag.base0B}";
        format = "[ $duration]($style)";
      };

      nix_shell = {symbol = " ";};

      os = {
        disabled = false;
        style = "fg:${withHashtag.base01} bg:${withHashtag.base08}";
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
