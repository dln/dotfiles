{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./treesitter.nix
  ];

  programs.man.generateCaches = false;

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    extraLuaConfig = lib.fileContents ./init.lua;

    extraPackages = with pkgs; [
      black
      codeium
      cue
      go
      gopls
      gotools
      lua-language-server
      nil
      nixd
      nodePackages.prettier
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      rust-analyzer
      rustfmt
      shellcheck
      shfmt
      stylua
      vscode-langservers-extracted
    ];

    plugins = with pkgs.vimPlugins; [
      go-nvim
      rustaceanvim
      targets-vim
      ts-comments-nvim

      {
        plugin = blink-cmp;
        type = "lua";
        config = ''
          require'blink-cmp'.setup({
            keymap = 'super-tab',
            windows = {
              autocomplete = {
                border = 'none',
              },
              documentation = {
                border = 'rounded',
              },
              signature_help = {
                border = 'rounded',
              },
            },
          })
        '';
      }

      {
        plugin = codeium-nvim;
        type = "lua";
        config = ''
          require'codeium'.setup {
            enable_chat = false,
          }
        '';
      }

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "neocodeium";
          src = pkgs.fetchFromGitHub {
            owner = "monkoose";
            repo = "neocodeium";
            rev = "4da81528468b33585c411f31eb390dce573ccb14";  # v1.8.0
            hash = "sha256-1n9nNqBNwNDSzbAkm8eB4HZLNy5HmMg25jPwQAnW5OU=";
          };
        };
        type = "lua";
        config = ''
          local neocodeium =require('neocodeium')
          neocodeium.setup()
          vim.keymap.set("i", "<C-j>", neocodeium.accept, { remap = true })
          vim.keymap.set("i", "<A-f>", neocodeium.accept, { remap = true })
          vim.keymap.set("i", "<C-h>", neocodeium.cycle_or_complete, { remap = true })
        '';
      }

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "diagflow";
          src = pkgs.fetchFromGitHub {
            owner = "dgagn";
            repo = "diagflow.nvim";
            rev = "fc09d55d2e60edc8ed8f9939ba97b7b7e6488c99";
            hash = "sha256-2WNuaIEXcAgUl2Kb/cCHEOrtehw9alaoM96qb4MLArw=";
          };
        };
        type = "lua";
        config = ''
          require('diagflow').setup {
            scope = "line",
            gap_size = 0,
            max_width = 50,
            max_height = 20,
            show_borders = true,
            toggle_event = { "InsertEnter", "InsertLeave" },
          }
        '';
      }

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "dieter-nvim";
          src = ./dieter;
        };
        type = "lua";
        config = ''
          vim.cmd.colorscheme "dieter"
        '';
      }

      {
        plugin = mini-nvim;
        type = "lua";
        config = lib.fileContents ./mini.lua;
      }

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = lib.fileContents ./lsp.lua;
      }
    ];
  };
}
