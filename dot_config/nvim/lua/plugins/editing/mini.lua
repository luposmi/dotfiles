return {
    "echasnovski/mini.nvim",
    dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"},
    config = function()
        local ai = require("mini.ai")
        local gen_spec = ai.gen_spec
        ai.setup({
            custom_textobjects = {
                S = gen_spec.treesitter({ a = '@statement.outer', i = '@statement.inner'}),
                A = gen_spec.treesitter({ a = '@assignment.outer', i = '@assignment.inner'}),
                a = gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner'}),
                v = gen_spec.treesitter({ a = '@attribute.outer', i = '@attribute.inner'}),
                m = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                f = gen_spec.treesitter({ a = '@call.outer', i = '@call.inner' }),
                l = gen_spec.treesitter({ a = '@loop.outer', i = '@loop.inner' }),
                i = gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
                c = gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
                C = gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }),
                ['='] = gen_spec.treesitter({ a = '@block.outer', i = '@block.inner' }),

                -- Make `|` select both edges in non-balanced way
                ['|'] = gen_spec.pair('|', '|', { type = 'non-balanced' }),
            },
            n_lines = 500,

        })
        require("mini.align").setup()
        require("mini.jump").setup(
            {
                mappings = {
                    forward = 'f',
                    backward = 'F',
                    forward_till = 't',
                    backward_till = 'T',
                    repeat_jump = ';',
                },
                delay = {
                    highlight = 250,
                    idle_stop = 10000000,
                },
                silent = false,
            }
        )
        require("mini.statusline").setup()
        require("mini.tabline").setup()
        require("mini.icons").setup()
        require("mini.operators").setup()
        require("mini.surround").setup({
            custom_surroundings = {
                B = {
                    input = { '%*%*().-()%*%*'},

                    output = { left = "**", right = "**" } }
            }
        })
        local clue = require("mini.clue")
        clue.setup({
            triggers = {
                -- Leader triggers
                { mode = 'n', keys = '<Leader>' },
                { mode = 'x', keys = '<Leader>' },

                -- Built-in completion
                { mode = 'i', keys = '<C-x>' },

                -- `g`        key
                { mode = 'n', keys = 'g' },
                { mode = 'x', keys = 'g' },

                -- Mar        ks
                { mode = 'n', keys = "'" },
                { mode = 'n', keys = '`' },
                { mode = 'x', keys = "'" },
                { mode = 'x', keys = '`' },

                -- Registers
                { mode = 'n', keys = '"' },
                { mode = 'x', keys = '"' },
                { mode = 'i', keys = '<C-r>' },
                { mode = 'c', keys = '<C-r>' },

                -- Window commands
                { mode = 'n', keys = '<C-w>' },

                -- `z`        key
                { mode = 'n', keys = 'z' },
                { mode = 'x', keys = 'z' },
                -- `@`        key
                { mode = 'n', keys = '@' },
                { mode = 'x', keys = '@' },

                -- movement
                { mode = 'n', keys = '[' },
                { mode = 'x', keys = '[' },
                { mode = 'n', keys = ']' },
                { mode = 'x', keys = ']' },

                -- around inside
                { mode = 'v', keys = 'a' },
                { mode = 'v', keys = 'i' },
                { mode = 'v', keys = 'a' },
                { mode = 'v', keys = 'i' },

                -- latex compiler
                { mode = 'n', keys = '\\l' },
            },

            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                clue.gen_clues.builtin_completion(),
                clue.gen_clues.g(),
                clue.gen_clues.marks(),
                clue.gen_clues.registers(),
                clue.gen_clues.windows(),
                clue.gen_clues.z(),
            },
            window = {
                delay = 0
            }
        })
    end
}
