vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.signcolumn = "yes"

local servers = { "lua_ls", "pyright", "ts_ls", "html", "cssls" }

vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
});

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = servers
})

vim.lsp.config("lua_ls", {})
vim.lsp.config("html", {
  settings = {
    html = {
      autoClosingTags = true
    }
  }
})
vim.lsp.config("cssls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.enable(servers)

require("mini.pick").setup()
require("mini.pairs").setup({
  modes = { insert = true, command = false, terminal = false },
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  skip_ts = { "string" },

  mappings = {
    ["<"] = false,
  },
})
require("mini.surround").setup()
require("mini.statusline").setup()

require("blink.cmp").setup({
  fuzzy = { implementation = "lua" }, --"prefer_rust_with_warning" },
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
    ["<CR>"] = { "accept", "fallback"},
    ["<C-k>"] = { "select_prev", "fallback"},
    ["<C-j>"] = { "select_next", "fallback"},
    ["<C-h>"] = { "hide", "fallback"},
  }
})

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

require("toggleterm").setup({
  open_mapping = [[<C-\>]],
  direction = "float"
})

require("trouble").setup()

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

vim.keymap.set("n", "<leader>jk", ":q<CR>")

-- vim.keymap.set("n", "<leader>sh", ":vsplit<CR>:Telescope find_files<CR>")
-- vim.keymap.set("n", "<leader>sl", ":bel vsplit<CR>:Telescope find_files<CR>")
-- vim.keymap.set("n", "<leader>sj", ":bel split<CR>:Telescope find_files<CR>")
-- vim.keymap.set("n", "<leader>sk", ":split<CR>:Telescope find_files<CR>")
vim.keymap.set("n", "<leader>sh", ":vsplit<CR>:Pick files<CR>")
vim.keymap.set("n", "<leader>sl", ":bel vsplit<CR>:Pick files<CR>")
vim.keymap.set("n", "<leader>sj", ":bel split<CR>:Pick files<CR>")
vim.keymap.set("n", "<leader>sk", ":split<CR>:Pick files<CR>")

vim.keymap.set("n", "<leader>sm", ":res<CR>:vert res<CR>")
vim.keymap.set("n", "<leader>s=", "<C-w>=")

vim.keymap.set("n", "<space>ee", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<space>er", ":NvimTreeRefresh<CR>")

vim.keymap.set("n", "<leader>nh", ":set nohls<CR>")

vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

vim.keymap.set("n", "<Tab>", ":tabnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":tabprev<CR>")

vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>gg", ":Pick grep_live<CR>")

vim.keymap.set("n", "<leader>fp", ":Pick files<CR>")

vim.keymap.set("n", "<leader>gd", ":Trouble diagnostics toggle<CR>")

vim.keymap.set("n", "<leader>pc", pack_clean)
vim.keymap.set("n", "<leader>cc", ":checkhealth<CR>")
