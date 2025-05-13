local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "emmet" },
  }),
  formatting = {
    format = function(entry, item)
      --colorize only LSP suggestions
      if entry.source.name == "nvim_lsp" then
        local ok, tail_col_cmp = pcall(require, "tailwindcss-colorizer-cmp")
        if ok then
          return tail_col_cmp.formatter(entry, item)
        end
      end
      return item
    end,
  },
})

-- Autopairs
require("nvim-autopairs").setup({})
