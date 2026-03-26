vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if vim.bo.modified and vim.bo.modifiable then
      local ok, err = pcall(vim.cmd, "write")
      if not ok then
        vim.notify("Auto-save failed: " .. err, vim.log.levels.WARN)
      else
        vim.notify("Saved!", vim.log.levels.INFO)
      end
    end
  end,
})


-- 1
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    -- 2
    vim.api.nvim_create_autocmd("BufWritePre", {
      -- 3
      buffer = args.buf,
      callback = function()
        -- 4 + 5
        vim.lsp.buf.format {async = false, id = args.data.client_id }
      end,
    })
  end
})

