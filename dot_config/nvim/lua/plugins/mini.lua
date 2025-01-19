return {
    "echasnovski/mini.nvim",
    config = function()
        local ai = require("mini.ai")
        local gen_spec = ai.gen_spec
        ai.setup({
            custom_textobjects = {
                -- Tweak argument to be recognized only inside `()` between `;`
                -- a = gen_spec.argument({ brackets = { '%b()' }, separator = ';' }),

                -- Tweak function call to not detect dot in function name
                -- f = gen_spec.function_call({ name_pattern = '[%w_]' }),

                -- Function definition (needs treesitter queries with these captures)
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
                -- Module mappings. Use `''` (empty string) to disable one.
                mappings = {
                    forward = 'f',
                    backward = 'F',
                    forward_till = 't',
                    backward_till = 'T',
                    repeat_jump = ';',
                },

                -- Delay values (in ms) for different functionalities. Set any of them to
                -- a very big number (like 10^7) to virtually disable.
                delay = {
                    -- Delay between jump and highlighting all possible jumps
                    highlight = 250,

                    -- Delay between jump and automatic stop if idle (no jump is done)
                    idle_stop = 0,
                },

                -- Whether to disable showing non-error feedback
                -- This also affects (purely informational) helper messages shown after
                -- idle time if user input is required.
                silent = false,
            }
        )
        require("mini.icons").setup()
        require("mini.surround").setup()
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
