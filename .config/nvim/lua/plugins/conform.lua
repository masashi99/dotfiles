return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = function()
    local function has_biome_config(bufnr)
      local file = vim.api.nvim_buf_get_name(bufnr)
      local root = vim.fs.root(file, { "biome.json", "package.json", ".git" })
      return root and vim.fn.filereadable(root .. "/biome.json") == 1
    end

    local function formatter(bufnr)
      return has_biome_config(bufnr) and { "biome-check" } or { "prettier" }
    end

    return {
      formatters_by_ft = {
        javascript = formatter,
        javascriptreact = formatter,
        typescript = formatter,
        typescriptreact = formatter,
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "never",
      },
    }
  end,
}
