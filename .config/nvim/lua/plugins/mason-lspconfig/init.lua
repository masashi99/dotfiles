return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {},
    },
    "neovim/nvim-lspconfig",
  },
  opts = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    ensure_installed = {
      "lua_ls",
      "stylua",
      "ts_ls",
      "biome",
    },
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
    require("plugins.mason-lspconfig.lsp")
  end,
}
