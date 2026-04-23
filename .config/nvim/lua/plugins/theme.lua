return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    on_highlights = function(hl, c)
      hl.DiagnosticUnnecessary = { fg = c.fg_dark }
      hl.SnacksPickerPathHidden = { fg = c.fg_dark }
      hl.SnacksPickerPathIgnored = { fg = c.fg_dark }
      hl.SnacksPickerGitStatusIgnored = { fg = c.fg_dark }
      hl.SnacksPickerDir = { fg = c.fg_dark }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd[[colorscheme tokyonight]]
  end,
}
