-- Enable inline diagnostics
vim.diagnostic.config({
  virtual_lines = false, -- Disable virtual lines
  virtual_text = true, -- Show virtual text for diagnostics
  signs = true, -- Show signs in the gutter
  underline = true, -- Underline errors and warnings
  update_in_insert = false, -- Don't update diagnostics while typing
  severity_sort = true, -- Sort by severity
  float = {
    border = "rounded",
  },
})
