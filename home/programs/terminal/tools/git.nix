{
  pkgs,
  lib,
  ...
}: let
  general = ''
    .cache/
    tmp/
    *.tmp
    log/
  '';

  nix = ''
    result
    result-*
    .direnv/
  '';

  node = ''
    node_modules/
  '';

  python = ''
    venv
    .venv
    *pyc
    *.egg-info/
    __pycached__/
    .mypy_cache
  '';
  ignore = lib.concatStringsSep "\n" [general nix node python];
in {
  home.packages = with pkgs; [
    gist # manage github gists
    act # local github actions
  ];

  programs = {
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-dash # dashboard with pull requests and issues
        gh-eco # explore the ecosystem
        gh-cal # contributions calender terminal viewer
      ];
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      ignores = map (v: "${toString v}") (builtins.split "\n" ignore);
      userEmail = "44993244+retchohrips@users.noreply.github.com";
      userName = "retchohrips";
      extraConfig = {
        init = {defaultBranch = "main";};
        push = {autoSetupRemote = true;};
        url = {
          "https://github.com/".insteadOf = "github:";
        };
      };
      aliases = {
        br = "branch";
        c = "commit -m";
        ca = "commit -am";
        co = "checkout";
        d = "diff";
        df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
        edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
        fuck = "commit --amend -m";
        graph = "log --all --decorate --graph";
        ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
        pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
        af = "!git add $(git ls-files -m -o --exclude-standard | fzf -m)";
        st = "status";
        hist = ''
          log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all
        '';
        llog = ''
          log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative
        '';
      };
    };
  };
}
