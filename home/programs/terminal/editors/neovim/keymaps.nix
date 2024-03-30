{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleeader = " ";
    };

    keymaps = [
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR><Esc>";
        options.silent = true;
      }
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Exit terminal mode";
          silent = true;
        };
      }

      # General maps
      {
        mode = "n";
        key = "<leader>f";
        action = "+find/file";
      }
      {
        mode = "n";
        key = "<leader>s";
        action = "+search";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "+quit/session";
      }
      {
        mode = ["n" "v"];
        key = "<leader>g";
        action = "+git";
      }
      {
        mode = "n";
        key = "<leader>u";
        action = "+ui";
      }
      {
        mode = "n";
        key = "<leader>w";
        action = "+windows";
      }
      {
        mode = "n";
        key = "<leader><Tab>";
        action = "+tab";
      }
      {
        mode = ["n" "v"];
        key = "<leader>d";
        action = "+debug";
      }
      {
        mode = ["n" "v"];
        key = "<leader>c";
        action = "+code";
      }
      {
        mode = ["n" "v"];
        key = "<leader>t";
        action = "+test";
      }

      # Tabs
      {
        mode = "n";
        key = "<leader><tab>l";
        action = "<cmd>tablast<cr>";
        options = {
          silent = true;
          desc = "Last tab";
        };
      }
      {
        mode = "n";
        key = "<leader><tab>f";
        action = "<cmd>tabfirst<cr>";
        options = {
          silent = true;
          desc = "First Tab";
        };
      }
      {
        mode = "n";
        key = "<leader><tab><tab>";
        action = "<cmd>tabnew<cr>";
        options = {
          silent = true;
          desc = "New Tab";
        };
      }
      {
        mode = "n";
        key = "<leader><tab>]";
        action = "<cmd>tabnext<cr>";
        options = {
          silent = true;
          desc = "Next Tab";
        };
      }
      {
        mode = "n";
        key = "<leader><tab>d";
        action = "<cmd>tabclose<cr>";
        options = {
          silent = true;
          desc = "Close tab";
        };
      }
      {
        mode = "n";
        key = "<leader><tab>[";
        action = "<cmd>tabprevious<cr>";
        options = {
          silent = true;
          desc = "Previous Tab";
        };
      }

      # Windows
      {
        mode = "n";
        key = "<leader>ww";
        action = "<C-W>p";
        options = {
          silent = true;
          desc = "Other window";
        };
      }
      {
        mode = "n";
        key = "<leader>wd";
        action = "<C-W>c";
        options = {
          silent = true;
          desc = "Delete window";
        };
      }
      {
        mode = "n";
        key = "<leader>w-";
        action = "<C-W>s";
        options = {
          silent = true;
          desc = "Split window below";
        };
      }

      {
        mode = "n";
        key = "<leader>w|";
        action = "<C-W>v";
        options = {
          silent = true;
          desc = "Split window right";
        };
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options.desc = "Move focus to the left window";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options.desc = "Move focus to the right window";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options.desc = "Move focus to the lower window";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options.desc = "Move focus to the upper window";
        options.silent = true;
      }

      # Quit/Session
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>w<cr><esc>";
        options = {
          silent = true;
          desc = "Save file";
        };
      }
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>quitall<cr><esc>";
        options = {
          silent = true;
          desc = "Quit all";
        };
      }
      {
        mode = "n";
        key = "<leader>qs";
        action = ":lua require('persistence').load()<cr>";
        options = {
          silent = true;
          desc = "Restore session";
        };
      }
      {
        mode = "n";
        key = "<leader>ql";
        action = "<cmd>lua require('persistence').load({ last = true })<cr>";
        options = {
          silent = true;
          desc = "Restore last session";
        };
      }
      {
        mode = "n";
        key = "<leader>qd";
        action = "<cmd>lua require('persistence').stop()<cr>";
        options = {
          silent = true;
          desc = "Don't save current session";
        };
      }

      # ui
      {
        mode = "n";
        key = "<leader>ul";
        action = ":lua ToggleLineNumber()<cr>";
        options = {
          silent = true;
          desc = "Toggle Line Numbers";
        };
      }
      {
        mode = "n";
        key = "<leader>uL";
        action = ":lua ToggleRelativeLineNumber()<cr>";
        options = {
          silent = true;
          desc = "Toggle Relative Line Numbers";
        };
      }
      {
        mode = "n";
        key = "<leader>uw";
        action = ":lua ToggleWrap()<cr>";
        options = {
          silent = true;
          desc = "Toggle Line Wrap";
        };
      }

      # Modify keys that already exist
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options = {
          silent = true;
          desc = "Move up when line is highlighted";
        };
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options = {
          silent = true;
          desc = "Move down when line is highlighted";
        };
      }
      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
        options = {
          silent = true;
          desc = "Allow cursor to stay in the same place after appeding to current line";
        };
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options = {
          silent = true;
          desc = "Indent while remaining in visual mode.";
        };
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options = {
          silent = true;
          desc = "Indent while remaining in visual mode.";
        };
      }
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options = {
          silent = true;
          desc = "Allow <C-d> and <C-u> to keep the cursor in the middle";
        };
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options = {
          desc = "Allow C-d and C-u to keep the cursor in the middle";
        };
      }
      # Remap for dealing with word wrap and adding jumps to the jumplist.
      {
        mode = "n";
        key = "j";
        action.__raw = "
        [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']]
      ";
        options = {
          expr = true;
          desc = "Remap for dealing with word wrap and adding jumps to the jumplist.";
        };
      }
      {
        mode = "n";
        key = "k";
        action.__raw = "
        [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']]
      ";
        options = {
          expr = true;
          desc = "Remap for dealing with word wrap and adding jumps to the jumplist.";
        };
      }
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
        options = {
          desc = "Allow search terms to stay in the middle";
        };
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
        options = {
          desc = "Allow search terms to stay in the middle";
        };
      }
    ];

    extraConfigLua =
      /*
      lua
      */
      ''
        local notify = require("notify")

        local function show_notification(message, level)
          notify(message, level, { title = "Key pressed" })
        end

        function ToggleLineNumber()
        if vim.wo.number then
          vim.wo.number = false
          show_notification("Line numbers disabled", "info")
        else
          vim.wo.number = true
            vim.wo.relativenumber = false
            show_notification("Line numbers enabled", "info")
            end
            end

            function ToggleRelativeLineNumber()
            if vim.wo.relativenumber then
              vim.wo.relativenumber = false
              show_notification("Relative line numbers disabled", "info")
            else
              vim.wo.relativenumber = true
                vim.wo.number = false
                show_notification("Relative line numbers enabled", "info")
              end
            end

            function ToggleWrap()
              if vim.wo.wrap then
                vim.wo.wrap = false
                show_notification("Wrap disabled", "info")
              else
                vim.wo.wrap = true
                  vim.wo.number = false
                  show_notification("Wrap enabled", "info")
              end
            end

           if vim.lsp.inlay_hint then
             vim.keymap.set('n', '<leader>uh', function()
               vim.lsp.inlay_hint(0, nil)
             end, { desc = 'Toggle Inlay Hints' })
           end
      '';
  };
}
