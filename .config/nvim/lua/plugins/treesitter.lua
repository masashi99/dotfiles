return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ignored_filetypes = {
      noice = true,
    }

    require("nvim-treesitter").install({
      "lua",
      "javascript",
      "typescript",
      "go",
      "yaml",
      "toml",
      "sql",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then return end
        if ignored_filetypes[args.match] then return end

        local ok, lang = pcall(vim.treesitter.language.get_lang, args.match)
        if not ok or not lang then return end

        local started = pcall(vim.treesitter.start, args.buf, lang)
        if not started then
          return
        end
      end,
    })
  end,
}
