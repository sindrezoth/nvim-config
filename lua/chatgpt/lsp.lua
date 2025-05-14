local lspconfig = require("lspconfig")

-- TypeScript/JavaScript/React
lspconfig.ts_ls.setup({
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.renameProvider = false
  end,
})

-- TailwindCSS
lspconfig.tailwindcss.setup({
  root_dir = require("lspconfig.util").root_pattern(
    "tailwind.config.js",
    "tailwind.config.ts",
    "postcss.config.js",
    "package.json",
    "node_modules"
  ),
})

-- HTML/CSS
lspconfig.html.setup({})
-- lspconfig.cssls.setup({})

-- Lua (for config)
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
