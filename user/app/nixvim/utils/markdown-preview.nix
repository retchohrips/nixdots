{userSettings, ...}: {
  programs.nixvim = {
    plugins.markdown-preview = {
      enable = true;
      browser = "${userSettings.browser}";
      theme = "dark";
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>cp";
        action = "<cmd>MarkdownPreview<cr>";
        options = {
          desc = "Markdown Preview";
        };
      }
    ];
  };
}
