vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.signcolumn = "yes"

vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  'saghen/blink.lib',
  'saghen/blink.cmp',
})

require("mason").setup({
  ensure_installed = { "vtsls", "lua_ls" }
})
require("mason-lspconfig").setup({})
require("nvim-treesitter.config")

local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup({
  sources = {
    default = { "lsp", "snippets", "path", "buffer" },
  },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
  resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  },
}

vim.lsp.config("vtsls", { single_file_support = false
})
vim.lsp.enable("vtsls")

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
})
vim.lsp.enable("lua_ls")
