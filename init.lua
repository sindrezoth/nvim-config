vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.signcolumn = "yes"

local servers = { "lua_ls", "pyright", "ts_ls" }

vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
});

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = servers
})

vim.lsp.config("lua_ls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.enable(servers)

require("mini.pick").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.statusline").setup()

-- require("telescope").setup()

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
vim.keymap.set("n", "<leader>sh", ":vsplit<CR>")
vim.keymap.set("n", "<leader>sl", ":bel vsplit<CR>:Telescope find_files<CR>")
vim.keymap.set("n", "<leader>sj", ":bel split<CR>")
vim.keymap.set("n", "<leader>sk", ":split<CR>")
vim.keymap.set("n", "<leader>sm", ":res<CR>:vert res<CR>")
vim.keymap.set("n", "<leader>s=", "<C-w>=")

vim.keymap.set("n", "<leader>nh", ":set nohls<CR>")

vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

vim.keymap.set("n", "<leader>pc", pack_clean)
vim.keymap.set("n", "<leader>cc", ":checkhealth<CR>")


vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
