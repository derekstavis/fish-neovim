-- Floating-window completion picker used by the fish `nvim` package.
--
-- Invoked synchronously from `nvr --remote-expr` (via `dofile(...)(...)`)
-- while a fish shell running in a neovim terminal is servicing a Tab
-- keypress. This file returns a single function that:
--   1. Takes a list of candidates ("value\tdescription" each), passed
--      directly as a Vim List literal in the remote-expr call -- no temp
--      file involved.
--   2. Opens a floating window near the cursor showing the (fuzzy-filterable)
--      list.
--   3. Blocks on a getcharstr()/keytrans() loop -- this is what lets it
--      capture keystrokes even though the underlying window is a terminal
--      buffer in terminal-mode; see the neovim package's own notes on this.
--   4. Returns the chosen candidate's value, or "" if cancelled.
--
-- No dependency on the user's own nvim config or plugins.

return function(raw_lines)
  local items = {}
  for _, line in ipairs(raw_lines) do
    if line ~= "" then
      local value, desc = line:match("^([^\t]*)\t?(.*)$")
      table.insert(items, { value = value, desc = desc or "" })
    end
  end

  if #items == 0 then
    return ""
  end

  local filter = ""
  local selected = 1
  local list = items

  local function recompute()
    if filter == "" then
      list = items
    else
      list = {}
      local lf = filter:lower()
      for _, it in ipairs(items) do
        if it.value:lower():find(lf, 1, true) then
          table.insert(list, it)
        end
      end
    end
    if selected > #list then selected = #list end
    if selected < 1 then selected = 1 end
  end

  local width = 40
  for _, it in ipairs(items) do
    local w = #it.value + (#it.desc > 0 and (2 + #it.desc) or 0)
    if w + 2 > width then width = w + 2 end
  end
  width = math.min(width, 80)
  local height = math.min(#items, 14) + 1

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "cursor",
    row = 1,
    col = 0,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
  })

  local ns = vim.api.nvim_create_namespace("fish_complete_picker")

  local function render()
    local render_lines = { "> " .. filter }
    if #list == 0 then
      table.insert(render_lines, "(no matches)")
    else
      for _, it in ipairs(list) do
        local text = it.value
        if it.desc ~= "" then
          text = text .. "  " .. it.desc
        end
        table.insert(render_lines, text)
      end
    end

    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, render_lines)
    vim.bo[buf].modifiable = false

    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    vim.api.nvim_buf_add_highlight(buf, ns, "Comment", 0, 0, -1)
    if #list > 0 then
      vim.api.nvim_buf_add_highlight(buf, ns, "PmenuSel", selected, 0, -1)
    end

    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_set_cursor(win, { math.min(selected + 1, #render_lines), 0 })
    end
    vim.cmd("redraw")
  end

  render()

  local result = ""
  while true do
    local ok, ch = pcall(vim.fn.getcharstr)
    if not ok then
      result = ""
      break
    end

    local key = vim.fn.keytrans(ch)

    if key == "<Esc>" or key == "<C-C>" then
      result = ""
      break
    elseif key == "<CR>" then
      if #list > 0 then
        result = list[selected].value
      end
      break
    elseif key == "<Down>" or key == "<C-N>" or key == "<Tab>" then
      selected = selected + 1
      if selected > #list then selected = 1 end
      render()
    elseif key == "<Up>" or key == "<C-P>" or key == "<S-Tab>" then
      selected = selected - 1
      if selected < 1 then selected = #list end
      render()
    elseif key == "<BS>" or key == "<C-H>" then
      filter = filter:sub(1, -2)
      selected = 1
      recompute()
      render()
    elseif key == "<C-U>" then
      filter = ""
      selected = 1
      recompute()
      render()
    elseif #ch == 1 and ch:byte(1) >= 32 and ch:byte(1) < 127 then
      filter = filter .. ch
      selected = 1
      recompute()
      render()
    end
    -- anything else (other control/special keys) is ignored
  end

  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end

  return result
end
