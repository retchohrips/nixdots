{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./keymaps.nix

    ./cmp.nix
    ./git.nix
    ./snippets.nix
    ./telescope.nix

    ./format-lsp-syntax/conform.nix
    ./format-lsp-syntax/lint.nix
    ./format-lsp-syntax/lsp.nix
    ./format-lsp-syntax/lspsaga.nix
    ./format-lsp-syntax/none-ls.nix
    ./format-lsp-syntax/treesitter.nix
    ./format-lsp-syntax/trouble.nix
    ./format-lsp-syntax/typescript-tools.nix

    ./ui/alpha.nix
    ./ui/bufferline.nix
    ./ui/dressing.nix
    ./ui/fidget.nix
    ./ui/indent-blankline.nix
    # ./ui/neo-tree.nix # Disabled in favor of oil and sidebar
    ./ui/noice.nix
    ./ui/notify.nix
    ./ui/nui.nix
    ./ui/sidebar.nix
    ./ui/staline.nix

    ./utils/better-escape.nix
    ./utils/colorizer.nix
    ./utils/hardtime.nix
    ./utils/harpoon.nix
    ./utils/markdown-preview.nix
    ./utils/mini.nix
    ./utils/oil.nix
    ./utils/persistence.nix
    ./utils/project.nix
    ./utils/surround.nix
    ./utils/todo.nix
    ./utils/toggleterm.nix
    ./utils/ultimate-autopair.nix
    ./utils/undotree.nix
    ./utils/vim-be-good.nix
    ./utils/whichkey.nix
    ./utils/wilder.nix
  ];
  stylix.targets.nixvim = {
    transparent_bg.main = true;
    transparent_bg.sign_column = true;
  };
  programs.nixvim = {
    enable = true;
    options = {
      # Neovim options, i.e. vim.opt.
      number = true; # Enable line numbers
      relativenumber = false; # Disable relative line numbers

      #Hide end of file characters
      fcs = "eob:\ ";

      # Set tabs to 2 spaces
      tabstop = 2;
      softtabstop = 2;
      showtabline = 2;
      expandtab = true; # Allow using tab key to indent

      # Enable auto indenting and use spaces
      smartindent = true;
      shiftwidth = 2;

      # Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
      breakindent = true;

      # Enable incremental searching
      hlsearch = true;
      incsearch = true;

      # Enable text wrap
      wrap = true;

      # Better splitting
      splitbelow = true;
      splitright = true;

      # Enable mouse mode
      mouse = "a"; # Mouse

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

      # Enable 24-bit colors
      termguicolors = true;

      # Enable the sign column to prevent the screen from jumping
      signcolumn = "yes";

      # Enable cursor line highlight
      cursorline = true; # Highlight the line where the cursor is located

      # Set fold settings
      # These options were reccommended by nvim-ufo
      # See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      # Always keep 8 lines above/below cursor unless at start/end of file
      scrolloff = 8;

      # Place a column line
      # colorcolumn = "80";

      # Reduce which-key timeout to 10ms
      timeoutlen = 10;

      # Set encoding type
      encoding = "utf-8";
      fileencoding = "utf-8";

      # Change cursor options
      guicursor = [
        "n-v-c:block" # Normal, visual, command-line: block cursor
        "i-ci-ve:ver25" # Insert, command-line insert, visual-exclude: vertical bar cursor with block cursor, use "ver25" for 25% width
        "r-cr:hor20" # Replace, command-line replace: horizontal bar cursor with 20% height
        "o:hor50" # Operator-pending: horizontal bar cursor with 50% height
        "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor" # All modes: blinking settings
        "sm:block-blinkwait175-blinkoff150-blinkon175" # Showmatch: block cursor with specific blinking settings
      ];

      # Enable chars list
      # list = true; # Show invisible characters (tabs, eol, ...)
      # listchars = "eol:↲,tab:|->,lead:·,space: ,trail:•,extends:→,precedes:←,nbsp:␣";

      # More space in the neovim command line for displaying messages
      cmdheight = 2;

      # We don't need to see things like INSERT anymore
      showmode = false;

      # Maximum number of items to show in the popup menu (0 means "use available screen space")
      pumheight = 0;

      # Use conform-nvim for gq formatting. ('formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it)
      formatexpr = "v:lua.require'conform'.formatexpr()";

      laststatus = 3; # (https://neovim.io/doc/user/options.html#'laststatus')
    };
    extraConfigLua = ''
      local opt = vim.opt
      local g = vim.g
      local o = vim.o
        -- Neovide
      if g.neovide then
        -- Neovide options
        g.neovide_fullscreen = false
        g.neovide_hide_mouse_when_typing = false
        g.neovide_refresh_rate = 165
        g.neovide_cursor_vfx_mode = "ripple"
        g.neovide_cursor_animate_command_line = true
        g.neovide_cursor_animate_in_insert_mode = true
        g.neovide_cursor_vfx_particle_lifetime = 5.0
        g.neovide_cursor_vfx_particle_density = 14.0
        g.neovide_cursor_vfx_particle_speed = 12.0
        g.neovide_transparency = 0.8

        -- Neovide Fonts
        o.guifont = "${config.stylix.fonts.monospace.name}:Medium:h15"
      end
    '';
  };
}
