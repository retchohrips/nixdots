{inputs, ...}: {
  imports = [inputs.neovim-flake.homeManagerModules.default];
  programs.neovim-flake = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;

      spellcheck.enable = true;

      lsp = {
        formatOnSave = true;
        lightbulb.enable = true;
        nvimCodeActionMenu.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;
        lsplines.enable = true;
        nvim-docs-view.enable = true;
      };

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        html.enable = true;
        css.enable = true;
        ts.enable = true;
        python.enable = true;
        bash.enable = true;
      };

      visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
        scrollBar.enable = true;
        smoothScroll.enable = true;
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

      statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "frappe";
        transparent = false;
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
      };

      minimap.codewindow.enable = true;

      dashboard.alpha.enable = true;

      notify.nvim-notify.enable = true;

      projects.project-nvim.enable = true;

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

      notes.todo-comments.enable = true;

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
        illuminate.enable = true;
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            # this is a freeform module, it's `buftype = int;` for configuring column position
            nix = 110;
            ruby = 120;
            java = 130;
            go = [90 130];
          };
        };
      };

      comments = {
        comment-nvim.enable = true;
      };

      presence.neocord.enable = false;
    };
  };
}
