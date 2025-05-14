require("nvim-treesitter.configs").setup({
  modules = {},
  sync_install = false,
  ignore_install = {},
  auto_install = false,

  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "lua",
    "json",
  },
  highlight = { enable = true },
  -- autotag = { enable = true },
  indent = { enable = true },
})
