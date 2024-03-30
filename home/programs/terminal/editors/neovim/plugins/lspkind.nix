{
  programs.nixvim.plugins.lspkind = {
    # Adds pictograms to the lsp cmp
    enable = true;
    extraOptions = {
      maxwidth = 50;
      ellipsis_char = "...";
    };
  };
}
