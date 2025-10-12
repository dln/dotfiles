{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let

  nvimWrapper =
    let
      nvimPackage = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    in
    pkgs.symlinkJoin {
      name = "nvim-wrapper";
      meta = nvimPackage.meta // {
        description = "Neovim with environment variables";
      };
      lua = nvimPackage.lua;
      paths = [ nvimPackage ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/nvim \
          --run 'export CODESTRAL_API_KEY="$(cat ${config.age.secrets.codestral_api_key.path})"'
      '';
    };

  nvim-remote = pkgs.writeShellApplication {
    name = "nvim-remote";
    text = ''
      _sess=$(echo -n "$USER@''${SSH_CONNECTION:-$HOSTNAME}" | tr -c '[:alnum:]@.' '_')
      _nvim_sock="''${XDG_RUNTIME_DIR:-/tmp}/nvim.$_sess.sock"
      exec ${config.programs.neovim.finalPackage}/bin/nvim --listen "$_nvim_sock" --server "$_nvim_sock" "$@"
    '';
  };

in
{
  imports = [
    ./treesitter.nix
  ];

  home.packages = [
    nvim-remote
  ];

  programs.man.generateCaches = false;

  age.secrets = {
    codestral_api_key.file = ../../../secrets/codestral_api_key.age;
  };

  programs.neovide = {
    enable = true;
    settings = {
      neovim-bin = lib.getExe config.programs.neovim.finalPackage;
      font = {
        normal = [
          {
            family = "Go Mono";
            style = "Regular";
          }
          {
            family = "Symbols Nerd Font Mono";
            style = "Regular";
          }
        ];
        bold = [
          {
            family = "Go Mono";
            style = "Bold";
          }
          {
            family = "Symbols Nerd Font Mono";
            style = "Regular";
          }
        ];
        italic = [
          {
            family = "Go Mono";
            style = "Italic";
          }
          {
            family = "Symbols Nerd Font Mono";
            style = "Regular";
          }
        ];
        bold_italic = [
          {
            family = "Go Mono";
            style = "Bold Italic";
          }
          {
            family = "Symbols Nerd Font Mono";
            style = "Regular";
          }
        ];
        size = 10;
        hinting = "slight";
        edging = "subpixelantialias";
      };
      box-drawing = {
        mode = "native"; # "font-glyph", "native" or "selected-native"
        # selected = "🮐🮑🮒";
        sizes.default = [
          2
          4
        ]; # Thin and thick values respectively, for all sizes
      };
      theme = "light";
    };
  };

  programs.neovim = {
    enable = true;
    package = nvimWrapper;

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
            hash = "sha256-p2im4nUV0n9HQsjCA9oGJvTADfKGlCEr/RYWGlUszuU=";
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
          name = "jj-diffconflicts";
          src = pkgs.fetchFromGitHub {
            owner = "rafikdraoui";
            repo = "jj-diffconflicts";
            rev = "8140e5295ef2008a947f1f374c2d71a5bc7e38a0";
            hash = "sha256-LM2eP29yK+lIlWzJiIKIRcbVjNhyjV2unE4GJDTLKXQ=";
          };
        };
        type = "lua";
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
