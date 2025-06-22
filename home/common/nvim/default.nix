{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  nvim-remote = pkgs.writeShellApplication {
    name = "nvim-remote";
    text = ''
      _sess=$(echo -n "$USER@''${SSH_CONNECTION:-$HOSTNAME}" | tr -c '[:alnum:]@.' '_')
      _nvim_sock="''${XDG_RUNTIME_DIR:-/tmp}/nvim.$_sess.sock"
      exec nvim --listen "$_nvim_sock" --server "$_nvim_sock" "$@"
    '';
  };
in
{
  imports = [
    ./treesitter.nix
  ];

  home.packages = [ nvim-remote ];

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
      lua-language-server
      nixd
      shellcheck
      shfmt
      stylua
    ];

    plugins = with pkgs.vimPlugins; [
      blink-compat
      blink-emoji-nvim
      friendly-snippets
      go-nvim
      plenary-nvim
      targets-vim
      ts-comments-nvim

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "direnv-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "actionshrimp";
            repo = "direnv.nvim";
            rev = "main";
            hash = "sha256-7NcVskgAurbIuEVIXxHvXZfYQBOEXLURGzllfVEQKNE=";
          };
        };
        type = "lua";
        config = ''
          require('direnv-nvim').setup {
            type = "dir"
          }
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = lib.fileContents ./lsp.lua;
      }

      {
        plugin = blink-cmp;
        type = "lua";
        config = lib.fileContents ./blink-cmp.lua;
      }

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "inlay-hints";
          src = pkgs.fetchFromGitHub {
            owner = "MysticalDevil";
            repo = "inlay-hints.nvim";
            rev = "3259b54f3b954b4d8260f3ee49ceabe978ea5636";
            hash = "sha256-99KCGoPowa4PA1jkCm4ZbbgrFl84NWnKQMgkfy8KS5E=";
          };
        };
        type = "lua";
        config = ''
          require('inlay-hints').setup {
            autocmd = { enable = false },
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
          vim.cmd.colorscheme "dieter-nocolor"
        '';
      }

      {
        plugin = mini-nvim;
        type = "lua";
        config = lib.fileContents ./mini.lua;
      }

      {
        plugin = minuet-ai-nvim;
        type = "lua";
        config = ''
            require('minuet').setup {
            provider_options = {
              codestral = {
                optional = {
                  max_tokens = 256,
                  stop = { '\n\n' },
                },
              },
            },
            virtualtext = {
              auto_trigger_ft = {
                'go',
                'rust',
              },
              keymap = {
                accept = '<A-a>',
                accept_line = '<A-A>',
                accept_n_lines = '<A-z>',
                prev = '<A-[>',
                next = '<A-]>',
                dismiss = '<A-e>',
              },
            },
          }
        '';
      }

      {
        plugin = rustaceanvim;
        type = "lua";
        config = lib.fileContents ./rust.lua;
      }

    ];
  };
}
