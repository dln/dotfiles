{ lib, pkgs, ... }:
{
  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    viAlias       = true;
    vimAlias      = true;
    withNodeJs    = false;
    withPython3   = false;
    withRuby      = false;

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
      shellcheck
      shfmt
      stylua
      tree-sitter
      tree-sitter-grammars.tree-sitter-bash
      tree-sitter-grammars.tree-sitter-yaml
      tree-sitter-grammars.tree-sitter-go
      tree-sitter-grammars.tree-sitter-markdown
      tree-sitter-grammars.tree-sitter-lua
      tree-sitter-grammars.tree-sitter-html
      tree-sitter-grammars.tree-sitter-vim
      tree-sitter-grammars.tree-sitter-nix
      vscode-langservers-extracted
    ];


    plugins = with pkgs.vimPlugins; [
      go-nvim
      rustaceanvim
      targets-vim 

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "dieter-nvim";
          src = pkgs.fetchgit {
            url = "https://patagia.dev/Patagia/dieter.nvim.git";
            rev = "08fae6ffec4ae70ba6b2e1cafa780ff317ef0b61";
            hash = "sha256-C+Vo2SUVfNMkBwuLWqLoA59Pmy9aFwur7fBpfVkLm6Q=";
          };
        };
        type = "lua";
        config = ''
          vim.cmd.colorscheme "dieter"
        '';
      }

      {
        plugin = nvim-treesitter.withAllGrammars; # Treesitter
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup {
            highlight = { enable = true, },
            indent = { enable = true },
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
