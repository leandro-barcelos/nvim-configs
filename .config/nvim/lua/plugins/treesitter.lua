return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    vim.filetype.add({
      extension = {
        slang = "slang",
        slangh = "slang",
      },
    })

    local ts = require("nvim-treesitter")
    local languages = { "c", "cpp", "cmake", "lua", "python", "json", "jsonc", "slang" }

    ts.install(languages)

    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local maps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
    }
    for lhs, query in pairs(maps) do
      vim.keymap.set({ "o", "x" }, lhs, function()
        select.select_textobject(query)
      end, { desc = "TS textobject " .. query })
    end

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
