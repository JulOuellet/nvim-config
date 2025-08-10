return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",

	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		signature = { enabled = true },

		cmdline = {
			enabled = true,

			completion = {
				menu = {
					auto_show = function(ctx)
						-- start to auto_show cmdline suggestions only after the first space
						-- it avoids conflicts with quick commands like :wq
						return string.match(ctx.line, "%s")
					end,
				},
			},

			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
			},
		},
	},
}
