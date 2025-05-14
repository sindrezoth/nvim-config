require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    -- "tailwindcss",
    "eslint",
    "html",
    "cssls",
    "lua_ls",
  },
})
