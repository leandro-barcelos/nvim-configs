return {
  "Civitasv/cmake-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "akinsho/toggleterm.nvim", -- Add toggleterm as dependency
  },
  config = function()
    require("cmake-tools").setup({
      cmake_command = "cmake",
      cmake_build_directory = "build",
      cmake_build_directory_prefix = "",
      cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = {},
      cmake_console_size = 10,
      cmake_console_position = "belowright",
      cmake_show_console = "always",
      cmake_dap_configuration = {
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
      cmake_runner = {
        name = "toggleterm",
        opts = {
          direction = "horizontal",
          close_on_exit = false,
          auto_scroll = true,
          singleton = true,
        },
      },
      cmake_executor = {
        name = "toggleterm",
        opts = {
          direction = "horizontal",
          close_on_exit = false,
          auto_scroll = true,
          singleton = true,
        },
      },
      cmake_terminal = {
        name = "toggleterm",
        opts = {
          direction = "horizontal",
          close_on_exit = false,
          auto_scroll = true,
        },
      },
    })

    -- Keymaps
    local keymap = vim.keymap.set
    keymap("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
    keymap("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
    keymap("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
    keymap("n", "<leader>cd", "<cmd>CMakeDebug<cr>", { desc = "CMake Debug" })
    keymap("n", "<leader>cy", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake Select Build Type" })
    keymap("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select Build Target" })
    keymap("n", "<leader>cl", "<cmd>CMakeSelectLaunchTarget<cr>", { desc = "CMake Select Launch Target" })
    keymap("n", "<leader>cc", "<cmd>CMakeClean<cr>", { desc = "CMake Clean" })
    keymap("n", "<leader>cs", "<cmd>CMakeStop<cr>", { desc = "CMake Stop" })

    -- Additional custom keymaps for more control
    -- Build and Run in one command
    keymap("n", "<leader>cR", function()
      vim.cmd("CMakeBuild")
      vim.defer_fn(function()
        vim.cmd("CMakeRun")
      end, 1000) -- Wait 1 second after build before running
    end, { desc = "CMake Build & Run" })

    -- Quick access to cmake terminal
    keymap("n", "<leader>cT", function()
      require("toggleterm.terminal").Terminal:new({
        cmd = "bash",
        direction = "horizontal",
        close_on_exit = false,
        dir = vim.fn.getcwd(),
      }):toggle()
    end, { desc = "Open CMake Terminal" })
  end,
}
