local M = {}

local config_file = vim.fn.stdpath("config") .. "/obsidian_helper.config"

local subcommands = { "create" }

--- Read vault path from config file
---@return string|nil
local function read_vault_path()
	local f = io.open(config_file, "r")
	if not f then
		return nil
	end
	local path = f:read("*l")
	f:close()
	if path and path ~= "" then
		return path
	end
	return nil
end

--- Write vault path to config file
---@param path string
local function write_vault_path(path)
	local f = io.open(config_file, "w")
	if not f then
		vim.notify("Failed to write config file: " .. config_file, vim.log.levels.ERROR)
		return false
	end
	f:write(path .. "\n")
	f:close()
	return true
end

--- Subcommand: config
local function cmd_config()
	local current = read_vault_path() or ""
	vim.ui.input({
		prompt = "Obsidian vault path: ",
		default = current,
		completion = "dir",
	}, function(input)
		if not input or input == "" then
			return
		end
		local path = vim.fn.expand(input)
		path = path:gsub("/+$", "")
		if vim.fn.isdirectory(path) == 0 then
			vim.notify("Not a directory: " .. path, vim.log.levels.ERROR)
			return
		end
		if write_vault_path(path) then
			vim.notify("Obsidian vault path saved: " .. path, vim.log.levels.INFO)
		end
	end)
end

--- Collect directories inside vault
---@param vault string
---@return string[]
local function collect_dirs(vault)
	local escaped = vim.fn.shellescape(vault)
	local cmd
	if vim.fn.executable("fd") == 1 then
		cmd = string.format(
			"fd --type d --hidden --exclude .obsidian --exclude .git --exclude .trash . %s",
			escaped
		)
	else
		cmd = string.format(
			"find %s -mindepth 1 -type d"
				.. " -not -path '*/.obsidian/*' -not -name '.obsidian'"
				.. " -not -path '*/.git/*' -not -name '.git'"
				.. " -not -path '*/.trash/*' -not -name '.trash'"
				.. " | sort",
			escaped
		)
	end
	local output = vim.fn.systemlist(cmd)
	-- Prepend vault root as first entry
	table.insert(output, 1, vault)
	return output
end

--- Prompt for filename and open file
---@param dir string
local function prompt_and_open(dir)
	vim.ui.input({
		prompt = "Filename (without .md): ",
		default = os.date("%Y-%m-%d") .. "_",
	}, function(input)
		if not input or input == "" then
			return
		end
		if not input:match("%.md$") then
			input = input .. ".md"
		end
		local filepath = dir .. "/" .. input
		vim.cmd("edit " .. vim.fn.fnameescape(filepath))
		vim.notify("Opened: " .. filepath, vim.log.levels.INFO)
	end)
end

--- Subcommand: create
local function cmd_create()
	local vault = read_vault_path()
	if not vault then
		vim.notify("No vault configured. Run :ObsidianHelper config first.", vim.log.levels.WARN)
		return
	end
	if vim.fn.isdirectory(vault) == 0 then
		vim.notify("Vault directory does not exist: " .. vault, vim.log.levels.ERROR)
		return
	end

	local ok_pickers, pickers = pcall(require, "telescope.pickers")
	if not ok_pickers then
		vim.notify("Telescope is required but not installed.", vim.log.levels.ERROR)
		return
	end
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local dirs = collect_dirs(vault)

	pickers
		.new({}, {
			prompt_title = "Obsidian — select directory",
			finder = finders.new_table({
				results = dirs,
				entry_maker = function(entry)
					local display
					if entry == vault then
						display = ". (vault root)"
					else
						display = entry:sub(#vault + 2)
					end
					return {
						value = entry,
						display = display,
						ordinal = display,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						prompt_and_open(selection.value)
					end
				end)
				return true
			end,
		})
		:find()
end

function M.setup(_)
	vim.api.nvim_create_user_command("ObsidianHelper", function(opts)
		local sub = vim.trim(opts.args or "")
		if sub == "" then
			cmd_config()
		elseif sub == "create" then
			cmd_create()
		else
			vim.notify(
				"Unknown subcommand: " .. sub .. ". Valid: create (or no args for config)",
				vim.log.levels.ERROR
			)
		end
	end, {
		nargs = "?",
		complete = function(_, line, _)
			local parts = vim.split(line, "%s+")
			if #parts <= 2 then
				return vim.tbl_filter(function(s)
					return s:find(parts[2] or "", 1, true) == 1
				end, subcommands)
			end
			return {}
		end,
	})
end

return M
