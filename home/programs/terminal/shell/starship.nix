{
  lib,
  config,
  ...
}: {
  programs.starship = {
    enable = true;
    enableTransience = true;
    enableFishIntegration = true;
    settings = with config.lib.stylix.colors; {
      format = lib.concatStrings [
        "[](red)"
        "$os"
        "$hostname"
        "[](bg:${withHashtag.base09} fg:red)"
        "$directory"
        "[](bg:yellow fg:${withHashtag.base09})"
        "$git_branch"
        "$git_status"
        "[](fg:yellow bg:green)"
        "$nodejs"
        "$python"
        "[](fg:green bg:blue)"
        "$cmd_duration"
        "[ ](fg:blue)"
        "$line_break"
        "$character"
      ];
      os = {
        disabled = false;
        style = "bg:red fg:${withHashtag.base01}";
        symbols = {
          Android = " ";
          Arch = " ";
          Linux = " ";
          NixOS = " ";
          Unknown = " ";
          Windows = "󰍲 ";
        };
      };
      hostname = {
        style = "bg:red fg:${withHashtag.base01}";
        format = "[ $user]($style)";
      };
      directory = {
        style = "bg:${withHashtag.base09} fg:${withHashtag.base01}";
        format = "[ $path]($style)[$read_only ]($style)";
        read_only = " ";
        home_symbol = " ";
        truncation_length = 3;
        fish_style_pwd_dir_length = 1;
        truncation_symbol = "…/";
        truncate_to_repo = true;

        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };
      git_branch = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol $branch ](fg:${withHashtag.base01} bg:yellow)]($style)";
      };
      git_status = {
        style = "bg:yellow";
        format = "[[($all_status$ahead_behind )](fg:${withHashtag.base01} bg:yellow)]($style)";
        conflicted = " ";
        ahead = " ";
        behind = " ";
        diverged = "󰆗 ";
        up_to_date = " ";
        untracked = " ";
        stashed = " ";
        modified = " ";
        staged = " ";
        renamed = " ";
        deleted = " ";
      };
      nodejs = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version) ](fg:${withHashtag.base01} bg:green)]($style)";
      };
      python = {
        symbol = "";
        style = "bg:green";
        format = "[[ $symbol( $version )(\($virtualenv\) )](fg:${withHashtag.base01} bg:green)]($style)";
        python_binary = ["./venv/bin/python" "python" "python3" "python2"];
      };
      cmd_duration = {
        style = "bg:blue fg:${withHashtag.base01}";
        format = "[  $duration]($style)";
      };
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
    };
  };
  programs.fish.interactiveShellInit =
    /*
    fish
    */
    ''
      function starship_transient_prompt_func
        starship module character
      end'';
}
