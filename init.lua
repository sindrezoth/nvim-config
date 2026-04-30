vim.o.exrc = true
vim.o.secure = true
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = true

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.signcolumn = "yes"

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 25
vim.g.netrw_altv = 2

vim.opt.langmap = "йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ.\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>/?,їЇ;]},іІ;sS"

vim.pack.add({
  "nvim-treesitter/nvim-treesitter",
  "saghen/blink.lib",
  "saghen/blink.cmp",
  "neovim/nvim-lspconfig",
  "mason-org/mason.nvim",
  "mason-org/mason-lspconfig.nvim",
  "nvim-mini/mini.nvim",

  "folke/tokyonight.nvim",
  "akinsho/toggleterm.nvim",
  "folke/trouble.nvim",
  "lewis6991/gitsigns.nvim",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/nvim-tree/nvim-tree.lua",

  -- "rafamadriz/friendly-snippets",
  -- "L3MON4D3/LuaSnip",
});

require('vim._core.ui2').enable()

local servers = { "lua_ls", "vtsls", "html", "cssls" }

require("mason").setup({
  ensure_installed = servers
})
require("mason-lspconfig").setup({})
require("nvim-treesitter.config")

local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
  fuzzy = { implementation = "prefer_rust_with_warning" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lsp = {
        score_offset = 100,
      },
      buffer = {
        score_offset = -50,
        keyword_length = 3, -- only show buffer after 5 chars
      },
      path = {
        score_offset = -5,
      },
    },
  },
  keymap = {
    ["<CR>"] = { "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-h>"] = { "hide", "fallback" },
  },
  completion = {
    accept = {
      auto_brackets = {
        enabled = false
      }
    }
  }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
  resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  },
}

vim.lsp.config("vtsls", { single_file_support = false })
vim.lsp.enable("vtsls")

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
})
vim.lsp.enable("lua_ls")

vim.lsp.config("lua_ls", {})
vim.lsp.config("html", {
  settings = {
    html = {
      autoClosingTags = true
    }
  }
})
vim.lsp.config("cssls", {})
-- vim.lsp.config("ts_ls", {})
vim.lsp.config("vtsls", {
  settings = {
    typescript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
    },
    javascript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
      },
    },
  },
})
vim.lsp.enable(servers)

local nvimTreeConfig = {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
require("nvim-tree").setup(nvimTreeConfig)

require("mini.pick").setup()
require("mini.pairs").setup({
  modes = { insert = true, command = false, terminal = false },
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  skip_ts = { "string" },

  mappings = { ["<"] = false,
  },
})
require("mini.surround").setup()
require("mini.statusline").setup()
require("mini.sessions").setup({
  directory = vim.fn.stdpath("data") .. "/sessions",
  autoread = false,
  autowrite = true,
  file = "",
})

local function session_name()
  return vim.fn.fnamemodify(vim.loop.cwd(), ":p:h:t")
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    require("mini.sessions").write(session_name())
  end,
})


local function restoreSession()
  local name = session_name()

  vim.defer_fn(function()
    local ok = pcall(require("mini.sessions").read, name)

    if ok then
      vim.cmd("filetype detect")
      vim.cmd("syntax enable")

      vim.defer_fn(function()
        vim.cmd("silent! LspRestart")
      end, 50)

      vim.defer_fn(function()
        vim.cmd("silent! TSBufEnable highlight")
      end, 50)
    end
  end, 50)
end

require("toggleterm").setup({
  open_mapping = [[<C-\>]],
  direction = "float"
})

require("trouble").setup()

require("fidget").setup({
  progress = {
    display = {
      done_ttl = 1,
    },
  },
  notification = {
    window = {
      winblend = 0,
    },
  },
})

local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}
  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print("No unused plugins.")
    return
  end

  local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end

vim.cmd.colorscheme("tokyonight-night")

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>s\\", restoreSession)

vim.keymap.set("n", "<leader>jk", ":q<CR>")

vim.keymap.set("n", "<leader>sh", ":vsplit<CR>:Pick files<CR>")
vim.keymap.set("n", "<leader>sl", ":bel vsplit<CR>:Pick files<CR>")
vim.keymap.set("n", "<leader>sj", ":bel split<CR>:Pick files<CR>")
vim.keymap.set("n", "<leader>sk", ":split<CR>:Pick files<CR>")

vim.keymap.set("n", "<leader>sm", ":res<CR>:vert res<CR>")
vim.keymap.set("n", "<leader>s=", "<C-w>=")
vim.keymap.set("n", "<leader>nh", ":set nohls<CR>")

vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

vim.keymap.set("n", "<leader>of", ":tabedit<CR>:Pick files<CR>")
vim.keymap.set("n", "<Tab>", ":tabnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":tabprev<CR>")

vim.keymap.set("n", "<space>nv", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<space>nr", ":NvimTreeRefresh<CR>")

vim.keymap.set("n", "<space>eo", "<Plug>NetrwRefresh", { silent = true })
vim.keymap.set("n", "<space>eo", ":Lex<CR>")

vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>gg", ":Pick grep_live<CR>")

vim.keymap.set("n", "<leader>gd", ":Trouble diagnostics toggle<CR>", { desc = "Show diagnostics toggle"})
vim.keymap.set("n", "<leader>gf", vim.diagnostic.open_float, { desc = "Show inline diagnostics"})

local function wrapToggle()
  vim.opt.wrap = not vim.opt.wrap:get()

  if vim.opt.wrap:get() then
    vim.opt.linebreak = true
    vim.opt.breakindent = true
  else
    vim.opt.linebreak = false
  end
end
vim.keymap.set("n", "<leader>lw", wrapToggle)

vim.keymap.set("n", "<leader>pc", pack_clean)
vim.keymap.set("n", "<leader>cc", ":checkhealth<CR>")
