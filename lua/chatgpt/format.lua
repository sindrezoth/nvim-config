local null_ls = require("null-ls")
-- local eslint_d = require("none-ls.diagnostics.eslint_d")
local eslint = require("none-ls.diagnostics.eslint")

null_ls.setup({ ---@diagnostic disable-line: redundant-parameter
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		-- eslint,
		-- eslint_d.with({
		-- 	diagnostics_format = "[eslint_d] #{m}",
		-- }),
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_augroup("LspFormatting", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("LspFormatting", {}),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
