return {
	"zbirenbaum/copilot.lua",
	enabled = false,
	cmd = "Copilot",
	event = "InsertEnter",

	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,

				keymap = {
					accept = "<Tab>",
					accept_word = "<C-Right>",
					next = "<C-Down>",
					prev = "<C-Up>",
					dismiss = "<C-Left>",
				},
			},
		})
	end,
}
