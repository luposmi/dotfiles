return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup()
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
