return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        gitcommit = { "typos" },
        javascript = { "typos" },
        javascriptreact = { "typos" },
        json = { "typos" },
        lua = { "typos" },
        markdown = { "typos" },
        sh = { "typos" },
        text = { "typos" },
        toml = { "typos" },
        typescript = { "typos" },
        typescriptreact = { "typos" },
        yaml = { "typos" },
      }

      local group = vim.api.nvim_create_augroup("nvim_lint_typos", { clear = true })

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function(args)
          if vim.fn.executable("typos") ~= 1 then
            return
          end

          local bufnr = args.buf
          if vim.bo[bufnr].buftype ~= "" then
            return
          end

          lint.try_lint()
        end,
        desc = "Run typos via nvim-lint",
      })
    end,
  },
}
