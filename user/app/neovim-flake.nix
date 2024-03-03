{pkgs, ...}: {
  programs.neovim-flake = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        assistant.copilot.enable = false;
        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          bash.enable = true;
          css.enable = true;
          html.enable = true;
          markdown.enable = true;
          nix.enable = true;
          python.enable = true;
          tailwind.enable = true;
          ts.enable = true;
        };

        lsp = {
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          nvimCodeActionMenu.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          lsplines.enable = true;
          nvim-docs-view.enable = true;
          # lspconfig.sources = {astro = "astro";};
        };

        maps.normal = {
          "<leader>wq" = {
            action = ":wq<CR>";
            silent = true;
            desc = "Save file and quit";
          };

          "<leader>w" = {
            action = ":w<CR>";
            desc = "Save file";
          };

          "<leader>q" = {
            action = ":q<CR>";
            desc = "Quit";
          };
        };

        debugger = {
          nvim-dap = {
            enable = false;
            ui.enable = false;
          };
        };

        treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [astro];

        visuals = {
          enable = true;
          nvimWebDevicons.enable = true;
          scrollBar.enable = true;
          smoothScroll.enable = true;
          cellularAutomaton.enable = false;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;

          indentBlankline = {
            enable = true;
            fillChar = null;
            eolChar = null;
            scope = {
              enabled = true;
            };
          };

          cursorline = {
            enable = true;
            lineTimeout = 0;
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        autopairs.enable = true;

        autocomplete = {
          enable = true;
          type = "nvim-cmp";
        };

        filetree = {
          nvimTree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions = false; # throws an annoying debug message
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = true; # lighter, faster, and uses lua for configuration
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = false;
        };

        utility = {
          ccc.enable = true;
          vim-wakatime.enable = true;
          icon-picker.enable = true;
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = true;
          };
        };

        notes = {
          obsidian.enable = false; # neovim fails to build if obsidian is enabled, waiting for fix
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            columnAt.languages = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = 110;
              ruby = 120;
              java = 130;
              go = [90 130];
            };
          };
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
        };
      };
    };
  };
}
