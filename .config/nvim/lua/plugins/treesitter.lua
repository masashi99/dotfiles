return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ignored_filetypes = {
      noice = true,
    }
    local react_filetypes = {
      javascriptreact = true,
      typescriptreact = true,
      jsx = true,
      tsx = true,
    }

    local function apply_react_indent(bufnr)
      if vim.bo[bufnr].buftype ~= "" then return end
      if not react_filetypes[vim.bo[bufnr].filetype] then return end

      vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    require("nvim-treesitter").install({
      "lua",
      "html",
      "javascript",
      "tsx",
      "typescript",
      "astro",
      "go",
      "markdown",
      "markdown_inline",
      "svelte",
      "vue",
      "xml",
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

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "javascriptreact", "typescriptreact", "jsx", "tsx" },
      callback = function(args)
        apply_react_indent(args.buf)
      end,
    })

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) then
        apply_react_indent(bufnr)
      end
    end
  end,
}
