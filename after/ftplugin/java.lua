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

-- Find JDTLS installation
local jdtls_path = "/nix/store/6gllwzji8fba4q0508mlrlayjbxf80lj-jdt-language-server-1.46.1/share/java/jdtls"
local launcher_jar = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar"
local nix_config_dir = jdtls_path .. "/config_linux"

-- NixOS workaround: JDTLS tries to write to its config directory, but NixOS store is read-only
-- We need to copy the config files to a writable location and use that instead
local home = os.getenv("HOME")
local config_dir = home .. "/.local/share/nvim/jdtls-config"

if vim.fn.filereadable(launcher_jar) == 0 then
	vim.notify("JDTLS launcher jar not found: " .. launcher_jar, vim.log.levels.ERROR)
	return
end

-- Copy NixOS config files to writable location on first run
-- This prevents "Read-only file system" errors when JDTLS tries to extract native libraries
if vim.fn.isdirectory(config_dir) == 0 then
	vim.fn.mkdir(config_dir, "p")
	vim.fn.system({ "cp", "-r", nix_config_dir .. "/.", config_dir })
	vim.notify("Copied JDTLS config to writable location: " .. config_dir, vim.log.levels.INFO)
end

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
		"java",
		"--add-modules=ALL-SYSTEM",
		"--add-opens=java.base/java.util=ALL-UNNAMED",
		"--add-opens=java.base/java.lang=ALL-UNNAMED",
		"--add-opens=java.base/java.nio.file=ALL-UNNAMED",
		"--add-opens=java.base/java.net=ALL-UNNAMED",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"-javaagent:" .. lombok_path,
		"-jar",
		launcher_jar,
		"-configuration",
		config_dir,
		"-data",
		workspace_dir,
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
			apt = {
				enabled = false,
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

		-- Add a missing import
		vim.keymap.set("n", "<leader>ji", function()
			vim.lsp.buf.code_action({
				filter = function(action)
					return action.kind and action.kind:match("^source.addMissingImports")
						or action.title:match("^Import")
						or action.title:match("^Add import")
				end,
				apply = true,
			})
		end, vim.tbl_extend("force", opts, { desc = "Add a missing import" }))

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
