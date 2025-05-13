require("core")

require(".lazy")
require(".scripts")
require("chatgpt")
require("chatgpt.plugins")

-- Set up LSP, Autocompletion, and other configuration
require("chatgpt.lsp")
require("chatgpt.mason")
require("chatgpt.cmp")
require("chatgpt.treesitter")
require("chatgpt.ui")
