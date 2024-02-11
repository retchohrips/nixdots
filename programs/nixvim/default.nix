{
  imports = [
    ./bufferline.nix
    ./neo-tree.nix
    ./lsp.nix
    ./telescope.nix
  ];

  home.shellAliases = {
    v = "nvim";
  };

  programs = {
    nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      colorschemes.catppuccin = {
        enable = true;
        flavour = "mocha";
        transparentBackground = true;
      };

      globals.mapleader = " "; # Set leader to spacebar
      globals.maplocalleader = " "; # Set localleader to spacebar

      options = {
        cmdheight = 0; # Hide cmd line unless needed
        completeopt = ["menu" "menuone" "noselect"]; # Options for insert mode completion
        number = true; # Enables line numbers
        relativenumber = false; # Disables relative line numbers
        cursorline = true; # Highlight hte line the cursor is on
        ignorecase = true; # Ignore case when searching
        smartcase = true; # Case sensitive searching
        undofile = true; # Persistent undo
        modeline = true; # Enables tags such as 'vim:ft=sh'
        expandtab = true; # Enable using tab key to insert spaces
        shiftwidth = 2; # Number of spaces used for indentation
        autoindent = true; # Enable auto indentation
        showmode = false; # Don't show modes in command line
        breakindent = true; # Wrap indent to match line start
        updatetime = 100; # Faster completion
        clipboard = "unnamedplus";
        smartindent = true;
        incsearch = true;
      };

      keymaps = [
        {
          key = "<leader>e";
          action = "<CMD>Neotree toggle<CR>";
        }
        {
          key = "<leader>fm";
          action = "<CMD> lua vim.lsp.buf.format()<CR>";
        }
        {
          # Escape terminal mode using ESC
          mode = "t";
          key = "<esc>";
          action = "<C-\\><C-n>";
        }
      ];

      plugins = {
        lightline.enable = true;
        nix.enable = true;
        which-key.enable = true;
        gitsigns.enable = true;
        comment-nvim.enable = true;
        trouble.enable = true;
        notify = {
          enable = true;
          backgroundColour = "#000000";
          fps = 60;
          stages = "fade";
        };
        toggleterm = {
          enable = true;
          openMapping = "<C-t>";
          direction = "horizontal";
        };
        # buffer navigation
        flash = {
          enable = true; # mapping
        };
        markdown-preview = {
          enable = true;
        };
        nvim-autopairs.enable = true;
        nvim-colorizer = {
          enable = true;
          userDefaultOptions.names = false;
        };
        # highlight all occurences of of WUTC(word under the cursor)
        illuminate = {
          enable = true;
        };
        todo-comments.enable = true;
      };
    };
  };
}
