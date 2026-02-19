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
					"neocmake",
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

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.config("neocmake", {
				capabilities = capabilities,
			})
			vim.lsp.enable("neocmake")

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP go to definition" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP go to declaration" })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP go to implementation" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code actions" })
			vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
		end,
	},
}
