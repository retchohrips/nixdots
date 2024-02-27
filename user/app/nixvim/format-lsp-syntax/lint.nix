{
  programs.nixvim = {
    plugins.lint = {
      enable = true;
      lintersByFt = {
        text = ["vale"];
        nix = ["statix"];
        lua = ["selene"];
        markdown = ["vale"];
        python = ["flake8"];
        javascript = ["eslint_d"];
        javascriptreact = ["eslint_d"];
        typescript = ["eslint_d"];
        typescriptreact = ["eslint_d"];
        json = ["jsonlint"];
        java = ["checkstyle"];
        dockerfile = ["hadolint"];
        css = ["stylelint"];
      };
    };
  };
}
