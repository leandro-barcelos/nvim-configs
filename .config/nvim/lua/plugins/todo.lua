return {
	"echasnovski/mini.hipatterns",
	version = false,
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("mini.hipatterns").setup({
			highlighters = {
				todo = {
					pattern = "%f[%w]()TODO()%f[%W]",
					group = "DiagnosticInfo",
				},
				fixme = {
					pattern = "%f[%w]()FIXME()%f[%W]",
					group = "DiagnosticError",
				},
				hack = {
					pattern = "%f[%w]()HACK()%f[%W]",
					group = "DiagnosticWarn",
				},
				note = {
					pattern = "%f[%w]()NOTE()%f[%W]",
					group = "DiagnosticHint",
				},
			},
		})

		vim.keymap.set("n", "]t", function()
			vim.fn.search("\\<(TODO\\|FIXME\\|HACK\\|NOTE)\\>", "W")
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			vim.fn.search("\\<(TODO\\|FIXME\\|HACK\\|NOTE)\\>", "bW")
		end, { desc = "Previous todo comment" })

		vim.keymap.set("n", "<leader>ft", function()
			require("telescope.builtin").live_grep({
				default_text = "TODO|FIXME|HACK|NOTE",
			})
		end, { desc = "Find TODOs" })
	end,
}
