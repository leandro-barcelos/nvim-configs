return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    local languages = { "c", "cpp", "cmake", "lua", "python", "json", "jsonc" }

    ts.install(languages)

    local group = vim.api.nvim_create_augroup("dotfiles_treesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = languages,
      callback = function(event)
        vim.treesitter.start(event.buf)
        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
