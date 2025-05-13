function CaseAwareReplaceRange(from, to)
  local function conver_case(original, replacement)
    if original:match("^[A-Z][a-z]+$") then
      -- print(replacement:sub(1, 1):upper() .. replacement:sub(2):lower())
      return replacement:sub(1, 1):upper() .. replacement:sub(2):lower()
    elseif original:match("^[A-Z]+$") then
      return replacement:upper()
    elseif original:match("^[a-z]+$") then
      print(original)
      return replacement:lower()
    else
      return replacement
    end
  end

  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] - 1
  local end_line = end_pos[2]
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)

  for i, line in ipairs(lines) do
    lines[i] = line:gsub(from, function(matched)
      return conver_case(matched, to)
    end)
  end

  vim.api.nvim_buf_set_lines(bufnr, start_line, end_line, false, lines)
end

vim.api.nvim_create_user_command("Rwc", function(opts)
  CaseAwareReplaceRange(opts.fargs[1], opts.fargs[2])
end, {
  nargs = "*",
  range = true,
})
