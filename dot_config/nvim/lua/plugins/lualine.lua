return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local function wallpaper_theme()
        local colors = dofile(vim.fn.stdpath("config") .. "/lua/config/wallpaper_palette.lua")

        local theme = {}
        for _, mode in ipairs({
          "normal",
          "insert",
          "visual",
          "replace",
          "command",
          "terminal",
          "inactive",
        }) do
          theme[mode] = {
            a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg, bg = colors.bg_statusline },
          }
        end

        theme.inactive.a = {
          fg = colors.fg_dark,
          bg = colors.bg_statusline,
        }

        return theme
      end

      opts.options = opts.options or {}
      opts.options.theme = wallpaper_theme()

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("WallpaperLualine", { clear = true }),
        pattern = "tokyonight*",
        callback = function()
          vim.schedule(function()
            local lualine = require("lualine")
            local config = lualine.get_config()
            config.options.theme = wallpaper_theme()
            lualine.setup(config)
          end)
        end,
      })
    end,
  },
}
