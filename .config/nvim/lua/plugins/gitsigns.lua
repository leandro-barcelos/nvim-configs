return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add          = { text = "+" },
				change       = { text = "~" },
				delete       = { text = "_" },
				topdelete    = { text = "‾" },
				changedelete = { text = "~" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			current_line_blame = false, -- toggleable
			update_debounce = 100,
			max_file_length = 40000,
		})

		-- Keymaps
		local gs = package.loaded.gitsigns

		vim.keymap.set("n", "]c", function()
			if vim.wo.diff then return "]c" end
			vim.schedule(gs.next_hunk)
			return "<Ignore>"
		end, { expr = true, desc = "Next hunk" })

		vim.keymap.set("n", "[c", function()
			if vim.wo.diff then return "[c" end
			vim.schedule(gs.prev_hunk)
			return "<Ignore>"
		end, { expr = true, desc = "Prev hunk" })

		vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
		vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
		vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
		vim.keymap.set("n", "<leader>hb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
	end,
}
