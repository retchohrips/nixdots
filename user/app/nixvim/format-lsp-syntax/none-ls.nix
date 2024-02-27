{
  programs.nixvim = {
    # So we're not actually using none-ls but it's here to install things for nvim-lint and conform I think?
    plugins.none-ls = {
      enable = false;
      enableLspFormat = false;
      updateInInsert = false;
      onAttach =
        /*
        lua
        */
        ''
          function(client, bufnr)
              if client.supports_method "textDocument/formatting" then
                vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.format { bufnr = bufnr }
                  end,
                })
              end
            end
        '';
      sources = {
        code_actions = {
          eslint_d.enable = true;
          gitsigns.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          checkstyle.enable = true;
          statix.enable = true;
          deadnix.enable = true;
          luacheck.enable = true;
          flake8.enable = true;
          eslint_d.enable = true;
        };
        formatting = {
          shfmt.enable = true;
          alejandra.enable = true;
          prettier = {
            enable = true;
            withArgs = ''
              {
                extra_args = { "--no-semi", "--single-quote" },
              }
            '';
          };
          rustfmt.enable = true;
          stylua.enable = true;
          black = {
            enable = true;
            withArgs = ''
              {
                extra_args = { "--fast" },
              }
            '';
          };
          jq.enable = true;
        };
      };
    };
    # keymaps = [
    #   {
    #     mode = [ "n" "v" ];
    #     key = "<leader>cf";
    #     action = "<cmd>lua vim.lsp.buf.format()<cr>";
    #     options = {
    #       silent = true;
    #       desc = "Format";
    #     };
    #   }
    # ];
  };
}
