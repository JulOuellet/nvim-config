return {
	"zk-org/zk-nvim",

	config = function()
		require("zk").setup({
			picker = "snacks_picker",
		})

		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>zn", function()
			Snacks.input({
				prompt = "Title: ",
			}, function(title)
				if title and title ~= "" then
					require("zk").new({ title = title })
				end
			end)
		end, { desc = "Create a new note" })

		vim.keymap.set(
			"n",
			"<leader>zf",
			"<Cmd>ZkNotes<CR>",
			vim.tbl_extend("force", opts, { desc = "Open zk notes picker" })
		)

		vim.keymap.set(
			"n",
			"<leader>zb",
			"<Cmd>ZkBacklinks<CR>",
			vim.tbl_extend("force", opts, { desc = "Find zk note backlinks" })
		)
	end,
}
