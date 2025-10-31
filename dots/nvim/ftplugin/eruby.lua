local function project_root()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then
    return vim.loop.cwd()
  end

  local parent = vim.fs.dirname(bufname)
  local root_marker = vim.fs.find({ ".git", "Gemfile" }, { path = parent, upward = true })[1]
  if root_marker then
    return vim.fs.dirname(root_marker)
  end

  return vim.loop.cwd()
end

local function normalize_controller_name(name)
  local controller = name:match("[%w_%-%:]+")
  if not controller then
    return nil
  end

  controller = controller:gsub("%-%-", "/")
  controller = controller:gsub("%-", "_")
  controller = controller:gsub(":", "/")
  return controller
end

local function resolve_stimulus_controller(controller)
  local root = project_root()
  local controllers_dir = vim.fs.normalize(root .. "/app/javascript/controllers")
  local suffixes = { "_controller.ts", "_controller.tsx", "_controller.js", "_controller.jsx" }

  for _, suffix in ipairs(suffixes) do
    local path = controllers_dir .. "/" .. controller .. suffix
    if vim.loop.fs_stat(path) then
      return path
    end
  end

  return controllers_dir .. "/" .. controller .. "_controller.js"
end

local function controller_under_cursor()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
  if not line then
    return nil
  end

  for attr in line:gmatch('data%-controller="([^"]+)"') do
    local controller = normalize_controller_name(attr:match("^[^%s]+"))
    if controller then
      return controller
    end
  end

  return nil
end

local function open_stimulus_controller()
  local controller = controller_under_cursor()
  if not controller then
    vim.notify("No data-controller attribute found on this line.", vim.log.levels.WARN)
    return
  end

  local target = resolve_stimulus_controller(controller)
  vim.cmd.edit(target)
end

vim.keymap.set("n", "<leader>os", open_stimulus_controller, {
  buffer = true,
  desc = "Open Stimulus controller",
})

vim.api.nvim_create_user_command("StimulusController", open_stimulus_controller, {
  desc = "Open Stimulus controller matching data-controller attribute",
  bang = false,
})
