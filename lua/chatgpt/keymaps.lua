local keymap = vim.keymap

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- Splits
keymap.set("n", "<leader>sh", "<cmd>abo vsp | Telescope find_files<cr>")
keymap.set("n", "<leader>sj", "<cmd>bel sp | Telescope find_files<cr>")
keymap.set("n", "<leader>sk", "<cmd>abo sp | Telescope find_files<cr>")
keymap.set("n", "<leader>sl", "<cmd>bel vsp | Telescope find_files<cr>")

keymap.set("n", "<leader>sd", "<cmd>q<cr>")

-- move
keymap.set("n", "<C-h>", "<C-w><C-h>")
keymap.set("n", "<C-l>", "<C-w><C-l>")
keymap.set("n", "<C-j>", "<C-w><C-j>")
keymap.set("n", "<C-k>", "<C-w><C-k>")

keymap.set("n", "<leader>s=", "<C-w>=")

keymap.set("n", "<leader>sm", "<C-w>_ | <C-w>|")

-- Diagnostics
keymap.set("n", "<leader>do", function()
	vim.lsp.buf.hover({ focus = false, border = "solid" })
end, { desc = "Show line diagnostics" })
keymap.set("n", "<leader>df", function()
	vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
end, { desc = "Show line diagnostics" })

-- Trouble.nvim
keymap.set("n", "<leader>di", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set("n", "<leader>dc", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
keymap.set("n", "<leader>ds", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Document Symbols" })
keymap.set(
	"n",
	"<leader>dl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions/Refs/ets" }
)
keymap.set("n", "<leader>dq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })
keymap.set("n", "<leader>dw", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
