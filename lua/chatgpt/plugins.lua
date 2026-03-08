return {
  -- {
  -- 	"xero/evangelion.nvim",
  -- 	lazy = false,
  -- 	priority = 1000,
  -- 	init = function()
  -- 		vim.cmd.colorscheme("evangelion")
  -- 	end,
  -- },
  -- {
  -- 	"rebelot/kanagawa.nvim",
  -- 	init = function()
  -- 		vim.cmd.colorscheme("kanagawa")
  -- 	end,
  -- },
  -- LSP and Autocompletion

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require("fidget").setup({
        window = {
          blend = 0,
          border = "rounded",
        },
        text = {
          spinner = "dots",
        },
      })
    end,
  },

  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  "saadparwaiz1/cmp_luasnip",
  "windwp/nvim-autopairs",

  -- Prettier integration
  {
    "nvimtools/none-ls.nvim",
    name = "null-ls",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require("chatgpt.format")
    end,
  },

  -- Color preview
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" }, -- Enable for all files
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          css = true,
          css_fn = true,
          tailwind = true,
          mode = "background", -- Or "foreground" for text-color
          virtualtext = false, -- "■",
        },
      })
    end,
  },

  -- Tailwind & Bootstrap("themaxmarchuk/tailwindcss-colors.nvim"),
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_wdith = 2,
      })
    end,
    opts = {},
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter", --run = ':TSUpdate'
    build = ":TSUpdate",
  },

  -- Errors list
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  -- Git integration
  "lewis6991/gitsigns.nvim",

  -- UI
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "kyazdani42/nvim-web-devicons",
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  },

  -- Autotag
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- Emmet
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascriptreact", "typescriptreact" },
    init = function()
      vim.g.user_emmet_mode = "n"
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
  },
  -- Wrapping (embrace)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
