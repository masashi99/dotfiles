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
    ensure_installed = {
      "lua_ls",
      "stylua",
    },
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
    require("plugins.mason-lspconfig.lsp")
  end,
}
