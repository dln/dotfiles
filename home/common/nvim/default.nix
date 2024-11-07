{
  inputs,
  lib,
  pkgs,
  ...
}:
{

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
      tree-sitter
      tree-sitter-grammars.tree-sitter-bash
      tree-sitter-grammars.tree-sitter-c
      tree-sitter-grammars.tree-sitter-comment
      tree-sitter-grammars.tree-sitter-css
      tree-sitter-grammars.tree-sitter-cue
      tree-sitter-grammars.tree-sitter-fish
      tree-sitter-grammars.tree-sitter-gdscript
      tree-sitter-grammars.tree-sitter-go
      tree-sitter-grammars.tree-sitter-gomod
      tree-sitter-grammars.tree-sitter-hcl
      tree-sitter-grammars.tree-sitter-html
      tree-sitter-grammars.tree-sitter-javascript
      tree-sitter-grammars.tree-sitter-json
      tree-sitter-grammars.tree-sitter-lua
      tree-sitter-grammars.tree-sitter-markdown
      tree-sitter-grammars.tree-sitter-nix
      tree-sitter-grammars.tree-sitter-proto
      tree-sitter-grammars.tree-sitter-rego
      tree-sitter-grammars.tree-sitter-rust
      tree-sitter-grammars.tree-sitter-scss
      tree-sitter-grammars.tree-sitter-sql
      tree-sitter-grammars.tree-sitter-svelte
      tree-sitter-grammars.tree-sitter-toml
      tree-sitter-grammars.tree-sitter-tsx
      tree-sitter-grammars.tree-sitter-typescript
      tree-sitter-grammars.tree-sitter-vim
      tree-sitter-grammars.tree-sitter-yaml
      tree-sitter-grammars.tree-sitter-zig
      vscode-langservers-extracted
    ];

    plugins = with pkgs.vimPlugins; [
      go-nvim
      rustaceanvim
      targets-vim
      ts-comments-nvim

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
        plugin = nvim-treesitter-context;
        type = "lua";
        config = ''
          require'treesitter-context'.setup{
            enable = false,
          }

          vim.keymap.set('n', '<space>ut', "<cmd>TSContextToggle<cr>", {noremap = true, silent = true, desc = "TS Context"})
        '';
      }

      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup {
            highlight = { enable = true, },
            indent = { enable = true },
            textobjects = {
              select = {
                enable = true,
                lookahead = true,
              },
            },
          }
        '';
      }

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-tree-pairs"; # make % match in TS
          src = pkgs.fetchFromGitHub {
            owner = "yorickpeterse";
            repo = "nvim-tree-pairs";
            rev = "e7f7b6cc28dda6f3fa271ce63b0d371d5b7641da";
            hash = "sha256-fb4EsrWAbm8+dWAhiirCPuR44MEg+KYb9hZOIuEuT24=";
          };
        };
        type = "lua";
        config = "require('tree-pairs').setup()";
      }

      {
        plugin = nvim-treesitter-textobjects; # helix-style selection of TS tree
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup {
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<M-o>",
                scope_incremental = "<M-O>",
                node_incremental = "<M-o>",
                node_decremental = "<M-i>",
              },
            },
          }
        '';
      }

      {
        plugin = mini-nvim;
        type = "lua";
        config = lib.fileContents ./mini.lua;
      }

      {
        plugin = nvim-lspconfig; # Interface for LSPs
        type = "lua";
        config = lib.fileContents ./lsp.lua;
      }
    ];
  };
}
