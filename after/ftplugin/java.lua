local set = vim.opt_local
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

local jdtls = require("jdtls")

-- Determine project name and workspace directory
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Find root directory
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local jdtls_install = vim.fn.exepath("jdtls")
if jdtls_install == "" then
	vim.notify("jdtls not found in PATH", vim.log.levels.ERROR)
	return
end

local home = os.getenv("HOME")
local lombok_path = home .. "/.local/share/nvim/lombok.jar"

if vim.fn.filereadable(lombok_path) == 0 then
	vim.notify("Downloading Lombok...", vim.log.levels.INFO)
	vim.fn.system({
		"curl",
		"-Lo",
		lombok_path,
		"https://projectlombok.org/downloads/lombok.jar",
	})
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to download Lombok", vim.log.levels.ERROR)
	else
		vim.notify("Lombok downloaded successfully", vim.log.levels.INFO)
	end
end

local config = {
	cmd = {
		"jdtls",
		"-data",
		workspace_dir,
		"--jvm-arg=-javaagent:" .. lombok_path,
		"--jvm-arg=-Xbootclasspath/a:" .. lombok_path,
	},

	root_dir = root_dir,

	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "automatic",
			},
			maven = {
				downloadSources = true,
			},
			codeLens = {
				implementations = {
					enabled = true,
				},
				references = {
					enabled = true,
				},
			},
			references = {
				includeDecompiledSources = true,
			},
			format = {
				enabled = true,
				settings = {
					profile = "Eclipse",
				},
			},
			signatureHelp = {
				enabled = true,
			},
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.junit.Assert.*",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
		},
	},

	init_options = {
		bundles = {},
	},

	capabilities = require("blink.cmp").get_lsp_capabilities(),

	on_attach = function(client, bufnr)
		local opts = { buffer = bufnr, silent = true }

		-- Organize imports
		vim.keymap.set("n", "<leader>jo", function()
			require("jdtls").organize_imports()
		end, vim.tbl_extend("force", opts, { desc = "Organize imports" }))

		-- Extract variable
		vim.keymap.set("n", "<leader>jv", function()
			require("jdtls").extract_variable()
		end, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
		vim.keymap.set("v", "<leader>jv", function()
			require("jdtls").extract_variable()
		end, vim.tbl_extend("force", opts, { desc = "Extract variable" }))

		-- Extract constant
		vim.keymap.set("n", "<leader>jc", function()
			require("jdtls").extract_constant()
		end, vim.tbl_extend("force", opts, { desc = "Extract constant" }))
		vim.keymap.set("v", "<leader>jc", function()
			require("jdtls").extract_constant()
		end, vim.tbl_extend("force", opts, { desc = "Extract constant" }))

		-- Extract method
		vim.keymap.set("v", "<leader>jm", function()
			require("jdtls").extract_method()
		end, vim.tbl_extend("force", opts, { desc = "Extract method" }))

		if client.server_capabilities.codeLensProvider then
			vim.lsp.codelens.refresh()

			vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
				buffer = bufnr,
				callback = vim.lsp.codelens.refresh,
			})
		end
	end,
}

jdtls.start_or_attach(config)
