local opts = {
    provider = "openai",
    openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",
        timeout = 50000,
        temperature = 0,
        max_completion_tokens = 8192,
        reasoning_effort = "high", -- low|medium|high, only used for reasoning models
    },
}

local dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",        -- for providers='copilot'
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
}

return {
    opts = opts,
    dependencies = dependencies,
}

