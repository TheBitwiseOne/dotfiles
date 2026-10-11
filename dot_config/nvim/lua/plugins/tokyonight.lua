return {
  {
    "folke/tokyonight.nvim",
    opts = {
      terminal_colors = false,
      transparent = true,
      cache = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        local path = vim.fn.stdpath("config") .. "/lua/config/wallpaper_palette.lua"

        local kitty_palette = vim.fn.expand("~/.config/kitty/colors.conf")
        if vim.fn.filereadable(kitty_palette) == 1 then
          for _, line in ipairs(vim.fn.readfile(kitty_palette)) do
            local index, color = line:match("^color(%d+)%s+(#%x+)")
            if index and tonumber(index) < 16 then
              vim.g["terminal_color_" .. index] = color
            end
          end
        end

        if vim.fn.filereadable(path) == 0 then
          return
        end

        local palette = dofile(path)
        for name, color in pairs(palette) do
          colors[name] = color
        end
        -- Stable semantic colours, independent of the wallpaper.
        colors.red = "#ff7b86"
        colors.red1 = "#ff7b86"
        colors.error = "#ff7b86"
        colors.green = "#95d67b"
        colors.green1 = "#95d67b"
        colors.green2 = "#95d67b"
        colors.yellow = "#e9c46a"
        colors.warning = "#e9c46a"
      end,

      on_highlights = function(hl, colors)
        local border = { fg = colors.blue, bg = "NONE" }

        hl.FloatBorder = border
        hl.WhichKeyBorder = border
        hl.SnacksWinBorder = border
        hl.SnacksPickerBorder = border

        hl.FloatTitle = { fg = colors.blue, bg = "NONE" }
        hl.Normal = { fg = colors.fg, bg = "NONE" }
        hl.NormalNC = { fg = colors.fg, bg = "NONE" }
        hl.SnacksNormal = { fg = colors.fg, bg = "NONE" }
        hl.SnacksNormalNC = { fg = colors.fg, bg = "NONE" }

        -- Transparent floating windows and picker panes.
        for _, group in ipairs({
          "NormalFloat",
          "SnacksPickerNormal",
          "SnacksPickerInput",
          "SnacksPickerList",
          "SnacksPickerPreview",
          "NoiceCmdlinePopup",
          "NoicePopup",
        }) do
          hl[group] = { fg = colors.fg, bg = "NONE" }
        end

        -- Wallpaper-colored picker borders and titles.
        for _, group in ipairs({
          "SnacksPickerBorder",
          "SnacksPickerInputBorder",
          "SnacksPickerListBorder",
          "SnacksPickerPreviewBorder",
          "SnacksPickerTitle",
          "SnacksPickerInputTitle",
          "SnacksPickerListTitle",
          "SnacksPickerPreviewTitle",
          "SnacksPickerBoxTitle",
        }) do
          hl[group] = { fg = colors.blue, bg = "NONE" }
        end

        -- Wallpaper-colored cmdline borders, titles and icons.
        for _, suffix in ipairs({
          "",
          "Cmdline",
          "Search",
          "Lua",
          "Input",
          "Calculator",
          "Filter",
          "Help",
          "IncRename",
        }) do
          for _, prefix in ipairs({
            "NoiceCmdlineIcon",
            "NoiceCmdlinePopupBorder",
            "NoiceCmdlinePopupTitle",
          }) do
            hl[prefix .. suffix] = { fg = colors.blue, bg = "NONE" }
          end
        end

        hl.NoiceCmdlinePrompt = { fg = colors.blue, bg = "NONE" }
      end,
    },
  },
}
