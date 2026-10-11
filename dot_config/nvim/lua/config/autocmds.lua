-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Reload TokyoNight when Matugen updates the wallpaper palette.
local palette_dir = vim.fn.stdpath("config") .. "/lua/config"
local watcher = vim.uv.new_fs_event()
local pending = 0

local function reload_wallpaper_theme()
  local scheme = vim.g.colors_name or ""
  if not scheme:match("^tokyonight") then
    return
  end

  local ok, err = pcall(vim.cmd.colorscheme, scheme)
  if not ok then
    vim.notify(tostring(err), vim.log.levels.ERROR)
  end
end

local ok, err = watcher:start(palette_dir, {}, function(error, filename)
  if error then
    return
  end
  if filename and filename ~= "wallpaper_palette.lua" then
    return
  end

  pending = pending + 1
  local current = pending

  -- Wait briefly for Matugen to finish writing.
  vim.defer_fn(function()
    if current == pending then
      reload_wallpaper_theme()
    end
  end, 150)
end)

if not ok then
  watcher:close()
  vim.notify("Palette watcher: " .. tostring(err), vim.log.levels.ERROR)
else
  vim.api.nvim_create_autocmd("VimLeavePre", {
    once = true,
    callback = function()
      pending = pending + 1
      watcher:stop()
      watcher:close()
    end,
  })
end
