return {
  "zk-org/zk-nvim",
  config = function()
    require("zk").setup({
      picker = "fzf",
      lsp = {
        config = {
          cmd = { "zk", "lsp" },
          name = "zk",
        },

        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      },
    })
  end,
}
