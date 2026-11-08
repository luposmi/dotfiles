local M = {}

local function fail(message)
  vim.notify("Codex: " .. message, vim.log.levels.ERROR)
end

local function action(args)
  local command = { "zellij", "--session", vim.env.ZELLIJ_SESSION_NAME, "action" }
  vim.list_extend(command, args)
  local result = vim.system(command, { text = true }):wait(2000)
  if result.code ~= 0 then
    fail(vim.trim(result.stderr or "") ~= "" and vim.trim(result.stderr) or "Zellij action failed or timed out")
    return nil
  end
  return result.stdout or ""
end

local function is_codex(command)
  if type(command) == "table" then
    command = table.concat(command, " ")
  end
  for word in tostring(command or ""):gmatch("%S+") do
    local executable = word:gsub("[\"']", ""):match("([^/]+)$")
    if executable == "codex" or executable == "codex.js" then
      return true
    end
  end
  return false
end

local function find_pane(panes)
  local candidates = {}
  for _, pane in ipairs(panes) do
    if not pane.is_plugin and not pane.exited and not pane.is_held
      and tostring(pane.id) ~= vim.env.ZELLIJ_PANE_ID then
      candidates[#candidates + 1] = pane
    end
  end
  for _, pane in ipairs(candidates) do
    if is_codex(pane.pane_command) or is_codex(pane.terminal_command) then
      return pane
    end
  end
  for _, pane in ipairs(candidates) do
    if tostring(pane.title or ""):lower():match("^codex%f[%W]") then
      return pane
    end
  end
  for _, pane in ipairs(candidates) do
    if tostring(pane.tab_name or ""):lower() == "codex" then
      return pane
    end
  end
end

function M.send_selection()
  if not vim.env.ZELLIJ_SESSION_NAME or vim.env.ZELLIJ_SESSION_NAME == "" then
    fail("Neovim must be running inside Zellij")
    return
  end
  if vim.fn.executable("zellij") ~= 1 then
    fail("zellij executable not found")
    return
  end

  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    fail("select text in Visual mode first")
    return
  end
  local first, last = vim.fn.getpos("v"), vim.fn.getpos(".")
  local lines = vim.fn.getregion(first, last, {
    type = mode,
    exclusive = vim.o.selection == "exclusive",
  })
  local text = table.concat(lines, "\n")
  if text == "" then
    fail("selection is empty")
    return
  end

  local filename = vim.api.nvim_buf_get_name(0)
  local prompt = string.format(
    "I'd like to discuss this passage. Suggest changes in chat; do not edit files yet.\n\nFile: %s\nLines: %d-%d%s\n\n%s\n\n",
    filename ~= "" and filename or "[unnamed buffer]",
    math.min(first[2], last[2]), math.max(first[2], last[2]),
    vim.bo.modified and " (unsaved buffer text)" or "", text
  )

  local output = action({ "list-panes", "--all", "--json" })
  if not output then
    return
  end
  local ok, panes = pcall(vim.json.decode, output)
  if not ok or type(panes) ~= "table" then
    fail("could not read Zellij pane information")
    return
  end
  local target = find_pane(panes)
  if not target then
    fail("no Codex pane found; run Codex in a tab named 'codex'")
    return
  end
  local pane_id = "terminal_" .. target.id
  -- Argument lists preserve LaTeX and quotes without going through a shell.
  -- Bracketed paste preserves newlines; deliberately do not send Enter.
  if not action({ "paste", "--pane-id", pane_id, "--", prompt }) then
    return
  end
  vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
  action({ "focus-pane-id", pane_id })
end

vim.keymap.set("x", "<leader>as", M.send_selection, {
  desc = "Send selection to Codex in Zellij",
})

return M
