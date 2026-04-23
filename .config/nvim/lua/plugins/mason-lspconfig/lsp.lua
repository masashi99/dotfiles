local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
        },
      },
    },
  },
})

-- menuone: 候補が1つでもメューを出す
-- noselect: メニューが出た際に自動で最初の候補を選択しない
-- noinsert: 候補を選んだだけでバッファに挿入しない
-- vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
--
-- -- 全てのLSPがアタッチした際に実行される共通設定
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if not client then return end
--
--     -- LSPが補完機能を持っているか確認
--     if client:supports_method("textDocument/completion") then
--       -- ネイティブの自動補完を有効化
--       vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--     end
--   end,
-- })
