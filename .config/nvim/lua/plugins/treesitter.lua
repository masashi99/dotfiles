return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
  },
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

    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local swap = require("nvim-treesitter-textobjects.swap")

    vim.keymap.set({ "x", "o" }, "af", function()
      select.select_textobject("@function.outer", "textobjects")
    end, { desc = "Select function outer" })
    vim.keymap.set({ "x", "o" }, "if", function()
      select.select_textobject("@function.inner", "textobjects")
    end, { desc = "Select function inner" })
    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer", "textobjects")
    end, { desc = "Select class outer" })
    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner", "textobjects")
    end, { desc = "Select class inner" })
    vim.keymap.set({ "x", "o" }, "ap", function()
      select.select_textobject("@parameter.outer", "textobjects")
    end, { desc = "Select parameter outer" })
    vim.keymap.set({ "x", "o" }, "ip", function()
      select.select_textobject("@parameter.inner", "textobjects")
    end, { desc = "Select parameter inner" })

    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      move.goto_next_start("@function.outer", "textobjects")
    end, { desc = "Next function start" })
    vim.keymap.set({ "n", "x", "o" }, "]M", function()
      move.goto_next_end("@function.outer", "textobjects")
    end, { desc = "Next function end" })
    vim.keymap.set({ "n", "x", "o" }, "[m", function()
      move.goto_previous_start("@function.outer", "textobjects")
    end, { desc = "Previous function start" })
    vim.keymap.set({ "n", "x", "o" }, "[M", function()
      move.goto_previous_end("@function.outer", "textobjects")
    end, { desc = "Previous function end" })
    vim.keymap.set({ "n", "x", "o" }, "]]", function()
      move.goto_next_start("@class.outer", "textobjects")
    end, { desc = "Next class start" })
    vim.keymap.set({ "n", "x", "o" }, "][", function()
      move.goto_next_end("@class.outer", "textobjects")
    end, { desc = "Next class end" })
    vim.keymap.set({ "n", "x", "o" }, "[[", function()
      move.goto_previous_start("@class.outer", "textobjects")
    end, { desc = "Previous class start" })
    vim.keymap.set({ "n", "x", "o" }, "[]", function()
      move.goto_previous_end("@class.outer", "textobjects")
    end, { desc = "Previous class end" })

    vim.keymap.set("n", "<leader>a", function()
      swap.swap_next("@parameter.inner")
    end, { desc = "Swap next parameter" })
    vim.keymap.set("n", "<leader>A", function()
      swap.swap_previous("@parameter.inner")
    end, { desc = "Swap previous parameter" })

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
