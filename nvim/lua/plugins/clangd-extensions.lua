return {
	"p00f/clangd_extensions.nvim",
	ft = { "c", "cpp" },
	dependencies = {
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("clangd_extensions").setup({
			server = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
				},
			},
			extensions = {
				autoSetHints = true,
				inlay_hints = {
					only_current_line = false,
					show_parameter_hints = true,
					parameter_hints_prefix = "󰊕 ",
					other_hints_prefix = "󰊕 ",
				},
			},
		})

		vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch source/header" })
	end,
}