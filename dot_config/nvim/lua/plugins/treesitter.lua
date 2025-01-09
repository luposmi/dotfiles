return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {
            ensure_installed = {   "bash", "c", "clojure", "cmake", "commonlisp", "cpp", "css",
                "csv", "dart", "diff", "dockerfile",  "gdscript",
                "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go",
                "haskell", "html",  "java", "javascript", "json", "latex",  "llvm", "lua",
                 "nix", "ocaml",
                "python",  "rust",  "sql",
                 "typescript", "xml", "yaml", "zig", "kdl", "just"
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                }
            }
        }
    }
