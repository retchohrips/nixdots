{
  programs.nixvim = {
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    opts = {
      number = true;
      relativenumber = true;

      mouse = "a"; # Allow mouse

      # Set tabs to 2 spaces
      tabstop = 2;
      softtabstop = 2;
      showtabline = 2;
      expandtab = true;

      # Enable auto indenting and set it to spaces
      smartindent = true;
      shiftwidth = 2;

      breakindent = true; # wrap indent to match line start

      # Enable incremental searching
      hlsearch = true;
      incsearch = true;

      # Enable text wrap
      wrap = true;

      # Better splitting
      splitbelow = true;
      splitright = true;

      # Enable ignorecase + smartcase for better searching
      ignorecase = true;
      smartcase = true; # Don't ignore case with capitals
      grepprg = "rg --vimgrep";
      grepformat = "%f:%l:%c:%m";

      # Decrease updatetime
      updatetime = 50; # faster completion (4000ms default)

      # Set completeopt to have a better completion experience
      completeopt = ["menuone" "noselect" "noinsert"]; # mostly just for cmp

      # Enable persistent undo history
      swapfile = false;
      backup = false;
      undofile = true;

      # Enable the sign column to prevent the screen from jumping
      signcolumn = "yes";

      # Enable cursor line highlight
      cursorline = true;

      # Preview substitutions live, as you type!
      inccommand = "split";

      # Set fold settings
      # These options were reccommended by nvim-ufo
      # See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
      # foldmethod = "indent";
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      # Always keep 8 lines above/below cursor unless at start/end of file
      scrolloff = 8;

      # Reduce which-key timeout to 10ms
      timeoutlen = 10;

      # Set encoding type
      encoding = "utf-8";
      fileencoding = "utf-8";

      showmode = false; # modes will be in the status line, do not show in cmdline

      # Sets how neovim will display certain whitespace characters in the editor.
      # See `:help 'list'`
      # and `:help 'listchars'`
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };

      #Hide end of file characters
      fcs = "eob:\ ";

      # Maximum number of items to show in the popup menu (0 means "use available screen space")
      pumheight = 0;

      cmdheight = 0; # hide cmdline until needed

      # Use conform-nvim for gq formatting. ('formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it)
      formatexpr = "v:lua.require'conform'.formatexpr()";

      laststatus = 3; # (https://neovim.io/doc/user/options.html#'laststatus')
    };
  };
}
