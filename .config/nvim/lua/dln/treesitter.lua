require("nvim-treesitter.configs").setup {
        ensure_installed = "maintained",
        highlight = {enable = true},
        textobjects = {
                move = {
                        enable = true,
                        goto_next_start = {
                                ["]m"] = "@function.outer",
                                ["]]"] = "@class.outer"
                        },
                        goto_next_end = {
                                ["]M"] = "@function.outer",
                                ["]["] = "@class.outer"
                        },
                        goto_previous_start = {
                                ["[m"] = "@function.outer",
                                ["[["] = "@class.outer"
                        },
                        goto_previous_end = {
                                ["[M"] = "@function.outer",
                                ["[]"] = "@class.outer"
                        }
                },
                select = {
                        enable = true,
                        keymaps = {
                                -- You can use the capture groups defined in textobjects.scm
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                ["ic"] = "@class.inner",
                                -- Or you can define your own textobjects like this
                                ["iF"] = {
                                        python = "(function_definition) @function",
                                        cpp = "(function_definition) @function",
                                        c = "(function_definition) @function",
                                        java = "(method_declaration) @function"
                                }
                        }
                },
                swap = {
                        enable = true,
                        swap_next = {
                                ["<leader>l"] = "@parameter.inner"
                        },
                        swap_previous = {
                                ["<leader>h"] = "@parameter.inner"
                        }
                }
        },
        --- nvim-ts-autotag ---
        autotag = {
                enable = true,
                filetypes = {"html", "javascriptreact", "xml"}
        }
}
