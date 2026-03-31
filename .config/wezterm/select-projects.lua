local wezterm = require("wezterm")
local act = wezterm.action

local function trim(s)
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function shell_quote(s)
  return "'" .. s:gsub("'", "'\\''") .. "'"
end

local function get_ghq_command()
  local candidates = {
    "ghq",
    "/opt/homebrew/bin/ghq",
    "/usr/local/bin/ghq",
  }

  for _, candidate in ipairs(candidates) do
    local f = io.popen(candidate .. " --version 2>/dev/null")
    if f then
      local output = f:read("*a")
      f:close()
      if output and output ~= "" then
        return candidate
      end
    end
  end

  return nil
end

local function get_ghq_projects()
  local ghq = get_ghq_command()
  if not ghq then
    wezterm.log_error("ghq command not found")
    return {}
  end

  local f = io.popen(ghq .. " list --full-path 2>/dev/null")
  if not f then
    return {}
  end

  local choices = {}
  for line in f:lines() do
    local path = trim(line)
    if path ~= "" then
      local label = path:gsub("^" .. wezterm.home_dir .. "/", "~/")
      table.insert(choices, { label = label, id = path })
    end
  end
  f:close()

  table.sort(choices, function(a, b)
    return a.label < b.label
  end)

  return choices
end

local function apply_layout(window, pane, project_dir)
  local tab = pane:tab()
  if not tab then
    return
  end

  tab:set_zoomed(false)

  local root_pane = pane
  for _, info in ipairs(tab:panes_with_info()) do
    local target = info.pane
    if target:pane_id() ~= root_pane:pane_id() then
      target:activate()
      window:perform_action(act.CloseCurrentPane({ confirm = false }), target)
    end
  end

  root_pane:activate()
  window:perform_action(
    act.SendString("\x01\x0b" .. "cd " .. shell_quote(project_dir) .. " && clear && nvim .\n"),
    root_pane
  )

  local center_top = root_pane:split({
    direction = "Right",
    size = 0.50,
    cwd = project_dir,
  })

  center_top:split({
    direction = "Bottom",
    size = 0.50,
    cwd = project_dir,
  })

  center_top:split({
    direction = "Right",
    size = 0.34,
    cwd = project_dir,
  })

  root_pane:activate()
end

return wezterm.action_callback(function(window, pane)
  local choices = get_ghq_projects()

  window:perform_action(
    act.InputSelector({
      title = "Select ghq project",
      choices = choices,
      fuzzy = true,
      description = "j/k or arrow keys to move, Enter = accept, / = filter",
      action = wezterm.action_callback(function(_, _, id, _)
        if id then
          apply_layout(window, pane, id)
        end
      end),
    }),
    pane
  )
end)
