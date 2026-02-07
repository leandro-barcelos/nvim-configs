return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "cmake-format" },
        cmake = { "gersemi" },
        javascript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        python = { "ruff" },
        lua = { "stylua" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>gf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, {})
  end,
}
