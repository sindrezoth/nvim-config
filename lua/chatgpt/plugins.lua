return {
	-- LSP and Autocompletion
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"L3MON4D3/LuaSnip",
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
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            }
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },

	-- Tailwind & Bootstrap
	"themaxmarchuk/tailwindcss-colors.nvim",
	{
		"rafamadriz/friendly-snippets",
		opts = {},
		config = function()
			require("luasnip.loaders.from_vscode")
		end,
	},
	{ "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
	-- { "js-everts/cmp-tailwindcss-classname", opts = {} },
}
