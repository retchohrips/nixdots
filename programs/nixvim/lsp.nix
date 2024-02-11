{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      enabledServers = [
        "bashls"
        "nil_ls"
        "eslint"
        "html"
        "jsonls"
        "cssls"
        "yamlls"
      ];
    };

    lspkind = {
      enable = true;
      cmp = {
        enable = true;
        menu = {
          nvim_lsp = "[LSP]";
          nvim_lua = "[api]";
          path = "[path]";
          luasnip = "[snip]";
          buffer = "[buf]";
          neorg = "[norg]";
        };
      };
    };

    nvim-cmp = {
      enable = true;

      snippet.expand = "luasnip";

      mapping = {
        "<C-u>" = "cmp.mapping.scroll_docs(-3)";
        "<C-d>" = "cmp.mapping.scroll_docs(3)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<tab>" = "cmp.mapping.close()";
        "<c-n>" = {
          modes = ["i" "s"];
          action = "cmp.mapping.select_next_item()";
        };
        "<c-p>" = {
          modes = ["i" "s"];
          action = "cmp.mapping.select_prev_item()";
        };
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };

      sources = [
        {name = "path";}
        {name = "nvim_lsp";}
        {name = "luasnip";}
        {
          name = "buffer";
          # Words from other open buffers can also be suggested.
          option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
        }
      ];
    };

    luasnip = {
      enable = true;
    };

    conform-nvim = {
      enable = true;
      formatOnSave = {
        timeoutMs = 500;
        lspFallback = true;
      };
      formattersByFt = {
        javascript = ["prettier"];
        nix = ["alejandra"];
      };
    };

    treesitter = {
      enable = true;

      nixvimInjections = true;

      indent = true;
    };

    treesitter-context.enable = true;
    rainbow-delimiters.enable = true;
    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
    };
  };
}
