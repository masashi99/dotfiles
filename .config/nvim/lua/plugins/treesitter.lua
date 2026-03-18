return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
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
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then return end

        local has_parser = pcall(vim.treesitter.get_parser, args.buf, lang)
        if has_parser then
          vim.treesitter.start(args.buf, lang)
        end
      end,
    })
  end,
}
