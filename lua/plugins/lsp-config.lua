return {
	{
		"mason-org/mason.nvim",
		opts = {},
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pylsp",
					"vtsls",
					"rust_analyzer",
					"cssls",
					"neocmake",
					"djlsp",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.diagnostic.config({ virtual_text = true })

			local lsp_opts = {
				capabilities = capabilities,
			}

			vim.lsp.enable("lua_ls", lsp_opts)
			vim.lsp.enable("clangd", lsp_opts)
			vim.lsp.enable("pylsp", lsp_opts)
			vim.lsp.enable("vtsls", lsp_opts)
			vim.lsp.enable("rust_analyzer", lsp_opts)
			vim.lsp.enable("cssls", lsp_opts)
			vim.lsp.enable("neocmake", lsp_opts)
			vim.lsp.enable("djlsp", lsp_opts)

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
