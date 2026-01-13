{ config, pkgs, inputs, ... }:

{
  home.username = "deymos";
  home.homeDirectory = "/home/deymos";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings.vim = {
      clipboard = {
        enable = true;
        registers = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      lsp.enable = true;

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        ts = {
          enable = true;
          lsp.servers = ["ts_ls"];
          format.type = ["biome"];
        };

        python = {
          enable = true;
          lsp.servers = ["basedpyright"];
          format.type = ["ruff"];
        };

        rust = {
          enable = true;
          extensions.crates-nvim.enable = true;
        };

        svelte = {
          enable = true;
          format.type = ["prettier"];
          extraDiagnostics.types = ["eslint_d"];
        };

        nix = {
          enable = true;
          lsp.servers = ["nil"];
          format.type = ["alejandra"];
          extraDiagnostics.types = ["statix" "deadnix"];
        };

        html = {
          enable = true;
          treesitter.autotagHtml = true;
        };

        css = {
          enable = true;
          format.type = ["biome"];
        };

        tailwind.enable = true;

        json.enable = true;
        yaml.enable = true;

        markdown = {
          enable = true;
          format.type = ["deno_fmt"];
        };
      };

      # Theme
      theme = {
        enable = true;
        name = "catppuccin";
        style = "frappe";
      };

      # UI
      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      filetree.neo-tree.enable = true;
      telescope.enable = true;

      # Git
      git.gitsigns.enable = true;

      # LSP Enhancements
      lsp.trouble.enable = true;
      lsp.lightbulb.enable = true;

      # Treesitter
      treesitter.context.enable = true;

      # Utility
      utility.surround.enable = true;
      utility.undotree.enable = true;
      utility.diffview-nvim.enable = true;

      # Navigation
      navigation.harpoon.enable = true;

      # Notes
      notes.todo-comments.enable = true;

      # Editor
      autopairs.nvim-autopairs.enable = true;
      comments.comment-nvim.enable = true;
      binds.whichKey.enable = true;

      # Autocomplete
      autocomplete.nvim-cmp.enable = true;

      # Visuals
      visuals = {
        nvim-web-devicons.enable = true;
        indent-blankline.enable = true;
        highlight-undo.enable = true;
        fidget-nvim.enable = true;
      };
      ui.colorizer.enable = true;

      # Custom Plugins
      extraPlugins = {
        vimtex = {
          package = pkgs.vimPlugins.vimtex;
          setup = ''
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_compiler_method = 'latexmk'
          '';
        };
      };
    };
  };

  home.packages = with pkgs; [
    deno
  ];
}
