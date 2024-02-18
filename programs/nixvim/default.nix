{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      transparentBackground = true;
      integrations = {
        cmp = true;
        gitsigns = true;
        telescope.enabled = true;
        markdown = true;
      };
    };
    clipboard.register = "unnamedplus"; # Use system clipboard
    globals.mapleader = " "; # Make spacebar the leader
    globals.maplocalleader = "m";
    options = {
      completeopt = ["menuone" "noselect"];
      conceallevel = 0;
      fileencoding = "utf-8";
      hlsearch = true;
      showmode = false; # Don't show modes in the cmd line
      breakindent = true; # Wrap indent to match line start
      number = true; # Show current line number
      backup = false;
      swapfile = false;
      modeline = true; # Tags such as 'vim:ft=sh'
      modelines = 100; # Sets the type of modelines
      splitright = true; # vertical split to the right
      splitbelow = true; # horizontal split to the bottom
      undofile = true; # Save and restore undo history
      autochdir = true;
      incsearch =
        true; # Incremental search: show match for partly typed search command
      ignorecase =
        true; # When the search query is lower-case, match both lower and upper-case
      smartcase =
        true; # Override the 'ignorecase' option if the search pattern contains upper
      expandtab = true; # use spaces instead of tabs
      shiftwidth = 2; # shift 2 spaces when tab
      tabstop = 2; # 1 tab == 2 spaces
      smartindent = true; # autoindent new lines
      wrap = false; # Disable line wrapping
      scrolloff = 5; # keep cursor away from top/bottom edge of the screen
      foldlevel = 99; # unfold everything by default
      cursorline = true; # highlight current line
      lazyredraw = true; # faster scrolling
      list = true; # show hidden characters
      exrc =
        true; # Loads project specific settings from .exrc, .nvimrc and .nvim.lua files
      # what hidden characters to show
      listchars = {
        trail = "•"; # trailing space
        tab = "» "; # tabs
      };
    };

    plugins = {
      bufferline = {
        enable = true;
        mode = "buffers";
        diagnostics = "nvim_lsp";
      };
      nvim-tree = {
        enable = true;
        syncRootWithCwd = true;
        modified.enable = true;
      };
      lualine = {
        enable = true;
        disabledFiletypes.statusline = ["dashboard" "NvimTree" "Outline"];
        sections = {
          lualine_a = ["mode"];
          lualine_b = [
            {
              name = "diagnostics";
              extraConfig = {
                source = ["nvim_diagnostic"];
                sections = ["error" "warn"];
                symbols = {
                  error = " ";
                  warn = " ";
                };
                colored = false;
                update_in_insert = false;
                always_visible = true;
              };
            }
          ];
          lualine_c = ["filename" "diff"];
          lualine_x = ["encoding"];
          lualine_y = ["filetype"];
          lualine_z = ["progress" "location"];
        };
      };

      which-key = {
        enable = true;
        registrations = {
          "<leader>b" = "Buffer";
          "<leader>f" = "File";
          "<leader><localleader>" = "Local";
          "<leader>s" = "Search";
        };
      };
      comment-nvim = {
        enable = true;
        padding = true;
        sticky = true;
      };
      nvim-autopairs.enable = true;
      nvim-colorizer.enable = true;
      telescope.enable = true;

      lsp = {
        enable = true;
        servers = {nixd.enable = true;};
        keymaps.diagnostic = {
          "<leader><localleader>i" = {
            action = "open_float";
            desc = "Open Diagnostic";
          };
          "<leader><localleader>n" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "<leader><localleader>p" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
          "[d" = {
            action = "goto_prev";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_next";
            desc = "Previous Diagnostic";
          };
        };
        keymaps.lspBuf = {
          "<leader><localleader>d" = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          "<leader><localleader>D" = {
            action = "definition";
            desc = "Goto Definition";
          };
          "<leader><localleader>f" = {
            action = "format";
            desc = "Format";
          };
          "<leader><localleader>h" = {
            action = "hover";
            desc = "Show Context";
          };
          "<leader><localleader>H" = {
            action = "signature_help";
            desc = "Signature Help";
          };
          "<leader><localleader>I" = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          "<leader><localleader>r" = {
            action = "rename";
            desc = "Rename";
          };
          "<leader><localleader>R" = {
            action = "references";
            desc = "References";
          };
        };
      };
      lsp-lines.enable = true;
      luasnip.enable = true;
      nvim-cmp = {
        enable = true;
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<Tab>" = {
            modes = ["i" "s"];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  fallback()
                end
              end
            '';
          };
          "<S-Tab>" = {
            modes = ["i" "s"];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                else
                  fallback()
                end
              end
            '';
          };
        };
        snippet.expand = "luasnip";
        completion.autocomplete = ["TextChanged"];
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "buffer";}
          {name = "path";}
        ];
        formatting = {
          fields = ["kind" "abbr" "menu"];
          format = ''
            function (entry, vim_item)
              vim_item.kind = string.format("%s",
                ({
                  Text = "󰉿",
                  Method = "󰆧",
                  Function = "󰊕",
                  Constructor = "",
                  Field = "",
                  Variable = "󰀫",
                  Class = "󰠱",
                  Interface = "",
                  Module = "",
                  Property = "󰜢",
                  Unit = "󰑭",
                  Value = "󰎠",
                  Enum = "",
                  Keyword = "󰌋",
                  Snippet = "",
                  Color = "󰏘",
                  File = "󰈙",
                  Reference = "",
                  Folder = "󰉋",
                  EnumMember = "",
                  Constant = "󰏿",
                  Struct = "",
                  Event = "",
                  Operator = "󰆕",
                  TypeParameter = "",
                  Misc = "",
                })[vim_item.kind]
              )
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[LSP]",
                luasnip = "[SNIP]",
                buffer = "[BUF]",
                path = "[PATH]",
              })[entry.source.name]
              return vim_item
            end
          '';
        };
      };

      none-ls = {
        enable = true;
        sources = {
          diagnostics = {
            cppcheck.enable = true;
            deadnix.enable = true;
          };
          formatting = {
            alejandra.enable = true;
            black.enable = true;
            jq.enable = true;
            markdownlint.enable = true;
            prettier.enable = true;
            stylelint.enable = true;
            # nixfmt.enable = true;
            # nixpkgs_fmt.enable = true;
          };
        };
      };

      treesitter = {
        enable = true;
        ensureInstalled = [
          "bash"
          "css"
          "fish"
          "latex"
          "lua"
          "make"
          "markdown"
          "markdown_inline"
          "nix"
          "python"
          "rasi"
          "regex"
          "vim"
        ];
        indent = true;
        folding = false;
      };
      nix.enable = true;
    };
    keymaps = [
      {
        key = ";";
        action = ":";
      }

      {
        key = "jk";
        action = "<ESC>";
        mode = "i";
      }

      {
        key = "<";
        action = "<gv";
        mode = "v";
        options.desc = "Un-Indent";
      }
      {
        key = ">";
        action = ">gv";
        mode = "v";
        options.desc = "Indent";
      }
      # {
      #   key = "/";
      #   action = "<CMD>CommentToggle<CR>";
      #   mode = "v";
      #   options.desc = "Toggle Comment";
      # }
      {
        key = "p";
        action = ''"_dP'';
        mode = "v";
        options.desc = "Put";
      }

      {
        key = "<C-h>";
        action = "<C-w>h";
        mode = "n";
        options.desc = "Move Focus Left";
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        mode = "n";
        options.desc = "Move Focus Down";
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        mode = "n";
        options.desc = "Move Focus Up";
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        mode = "n";
        options.desc = "Move Focus Right";
      }
      {
        key = "<C-Up>";
        action = "<cmd>resize +2<CR>";
        mode = "n";
        options.desc = "Heighten Split";
      }
      {
        key = "<C-Down>";
        action = "<cmd>resize -2<CR>";
        mode = "n";
        options.desc = "Shorten Split";
      }
      {
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<CR>";
        mode = "n";
        options.desc = "Narrow Split";
      }
      {
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<CR>";
        mode = "n";
        options.desc = "Widen Split";
      }
      # {
      #   key = "<leader>/";
      #   action = "<cmd>CommentToggle<CR>";
      #   mode = "n";
      #   options.desc = "Toggle Comment";
      # }
      {
        key = "<leader>w";
        action = "<cmd>w!<CR>";
        mode = "n";
        options.desc = "Save";
      }
      {
        key = "<leader>q";
        action = "<cmd>q!<CR>";
        mode = "n";
        options.desc = "Quit";
      }
      {
        key = "<leader>h";
        action = "<cmd>noh<CR>";
        mode = "n";
        options.desc = "Remove Highlight";
      }
      # TODO: Add dashboard
      # {
      #   key = "<leader>a";
      #   action = "<cmd>Alpha<CR>";
      #   mode = "n";
      #   options.desc = "Dashboard";
      # }
      {
        key = "<leader>bb";
        action = "<cmd>Telescope buffers theme=dropdown<CR>";
        mode = "n";
        options.desc = "Search Buffers";
      }
      {
        key = "<leader>bn";
        action = "<cmd>bnext<CR>";
        mode = "n";
        options.desc = "Next Buffer";
      }
      {
        key = "<leader>bp";
        action = "<cmd>bprevious<CR>";
        mode = "n";
        options.desc = "Previous Buffer";
      }
      {
        key = "<leader>bs";
        action = "<cmd>w<CR>";
        mode = "n";
        options.desc = "Save buffer";
      }
      {
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        mode = "n";
        options.desc = "Delete Buffer";
      }
      {
        key = "<leader>bk";
        action = "<cmd>bdelete<CR>";
        mode = "n";
        options.desc = "Kill Buffer";
      }
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        mode = "n";
        options.desc = "Find File";
      }
      {
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<CR>";
        mode = "n";
        options.desc = "Find Recent File";
      }
      {
        key = "<leader>ft";
        action = "<cmd>NvimTreeToggle<CR>";
        mode = "n";
        options.desc = "Toggle File Tree";
      }
      {
        key = "<leader><localleader>m";
        action = "<cmd>LspInfo<CR>";
        mode = "n";
        options.desc = "LSP Info";
      }
      {
        key = "<leader><localleader>M";
        action = "<cmd>Mason<CR>";
        mode = "n";
        options.desc = "LSP Manager";
      }
      {
        key = "<leader>sb";
        action = "<cmd>Telescope buffers theme=dropdown<CR>";
        mode = "n";
        options.desc = "Search Buffers";
      }
      {
        key = "<leader>sc";
        action = "<cmd>Telescope commands<CR>";
        mode = "n";
        options.desc = "Search Commands";
      }
      # {
      #   key = "<leader>sC";
      #   action = "<cmd>Telescope colorscheme<CR>";
      #   mode = "n";
      #   options.desc = "Search Colorschemes";
      # }
      {
        key = "<leader>sh";
        action = "<cmd>Telescope help_tags<CR>";
        mode = "n";
        options.desc = "Search Help";
      }
      {
        key = "<leader>sf";
        action = "<cmd>Telescope find_files<CR>";
        mode = "n";
        options.desc = "Search Files";
      }
      {
        key = "<leader>sm";
        action = "<cmd>Telescope man_pages<CR>";
        mode = "n";
        options.desc = "Search Man Pages";
      }
      {
        key = "<leader>sr";
        action = "<cmd>Telescope oldfiles<CR>";
        mode = "n";
        options.desc = "Search Recent Files";
      }
      {
        key = "<leader>sR";
        action = "<cmd>Telescope registers<CR>";
        mode = "n";
        options.desc = "Search Registers";
      }
      {
        key = "<leader>sk";
        action = "<cmd>Telescope keymaps<CR>";
        mode = "n";
        options.desc = "Search Keymaps";
      }
      {
        key = "<leader>st";
        action = "<cmd>Telescope live_grep theme=ivy<CR>";
        mode = "n";
        options.desc = "Search Text";
      }
    ];
    extraConfigLua = ''
      -- Highlight on Yank
      vim.cmd([[
           augroup highlight_yank
           autocmd!
           au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
           augroup END
      ]])
    '';
  };
}
