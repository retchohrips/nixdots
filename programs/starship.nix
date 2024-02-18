{lib, ...}: {
  programs.starship = let
    colors = import ../colors.nix;
  in {
    enable = true;
    enableTransience = true;
    settings = {
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

      nix_shell = {symbol = " ";};

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

      palettes.catppuccin = colors.scheme.catppuccin-mocha;
    };
  };
}
