local restore_explorer = false
local saved_explorer = false

local function is_snacks_picker_buffer(buf)
	if not vim.api.nvim_buf_is_valid(buf) then
		return false
	end

	local ft = vim.bo[buf].filetype
	return ft == "snacks_layout_box"
		or ft == "snacks_picker_list"
		or ft == "snacks_picker_input"
		or ft == "snacks_picker_preview"
end

local function explorer_pickers()
	local ok, pickers = pcall(function()
		return Snacks.picker.get({ source = "explorer", tab = false })
	end)

	if not ok then
		return {}
	end

	return pickers
end

local function pre_save()
	saved_explorer = #explorer_pickers() > 0

	for _, picker in ipairs(explorer_pickers()) do
		picker:close()
	end
end

local function save_extra_data()
	return vim.json.encode({
		explorer = saved_explorer,
	})
end

local function restore_extra_data(_, extra_data)
	local ok, data = pcall(vim.json.decode, extra_data)
	restore_explorer = ok and type(data) == "table" and data.explorer == true
end

local function cleanup_restored_picker_windows()
	local found = false

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if is_snacks_picker_buffer(buf) then
			found = true
			pcall(vim.api.nvim_win_close, win, true)
		end
	end

	return found
end

local function post_restore()
	vim.schedule(function()
		local had_picker_windows = cleanup_restored_picker_windows()

		if restore_explorer or had_picker_windows then
			restore_explorer = false
			Snacks.explorer({ cwd = vim.fn.getcwd() })
		end
	end)
end

return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		auto_save = true,
		auto_restore = true,
		args_allow_single_directory = true,
		git_use_branch_name = false,
		close_unsupported_windows = false,
		bypass_save_filetypes = { "snacks_dashboard" },
		pre_save_cmds = {
			pre_save,
		},
		save_extra_data = save_extra_data,
		restore_extra_data = restore_extra_data,
		post_restore_cmds = {
			post_restore,
		},
	},
}
