-- 外部更新の追従に関する autocmd をまとめるグループ。
local autoread_group = vim.api.nvim_create_augroup("autoread_on_external_change", { clear = true })
-- 起動直後の Explorer 表示に関する autocmd をまとめるグループ。
local startup_group = vim.api.nvim_create_augroup("startup_behavior", { clear = true })
-- セッション復元経由の起動かどうかを判定するフラグ。
local session_restored = false
-- Explorer の二重起動を防ぐためのフラグ。
local explorer_started = false

-- Snacks Explorer を必要なときだけ一度だけ開く。
local function open_explorer(cwd)
	if explorer_started then
		return
	end

	if not package.loaded["snacks"] then
		return
	end

	if #Snacks.picker.get({ source = "explorer" }) > 0 then
		explorer_started = true
		return
	end

	local ok = pcall(Snacks.explorer.open, cwd and { cwd = cwd } or {})
	if ok then
		explorer_started = true
	end
end

-- 他プロセスが変更したファイルを、Neovim に戻ってきたタイミングで再読込する。
vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold", "CursorHoldI", "TermClose", "TermLeave" }, {
	group = autoread_group,
	desc = "Reload files changed outside of Neovim",
	callback = function()
		if vim.fn.mode() == "c" then
			return
		end

		vim.cmd("checktime")
	end,
})

-- 外部変更検知時の確認プロンプトを出さず、削除以外は自動で再読込する。
vim.api.nvim_create_autocmd("FileChangedShell", {
	group = autoread_group,
	desc = "Always reload files changed outside of Neovim without prompting",
	callback = function()
		if vim.v.fcs_reason ~= "deleted" then
			vim.v.fcs_choice = "reload"
		end
	end,
})

-- 改行時にコメント継続しないよう formatoptions を調整する。
vim.api.nvim_create_autocmd("Filetype", {
	pattern = "*",
	callback = function()
    vim.opt_local.fo:remove({ "c", "r", "o" })
	end,
	desc = "disable comment in newline",
})

-- `nvim .` のようにディレクトリを指定して起動したとき、Explorer を開く。
vim.api.nvim_create_autocmd("VimEnter", {
	group = startup_group,
	desc = "Open Snacks explorer when Neovim starts on a directory",
	callback = function(args)
		if session_restored then
			return
		end

		local path = args.file
		if path == "" or vim.fn.isdirectory(path) ~= 1 then
			return
		end

		vim.schedule(function()
			vim.cmd.cd(vim.fn.fnameescape(path))
			if vim.fn.isdirectory(vim.api.nvim_buf_get_name(0)) == 1 then
				pcall(vim.cmd, "enew")
			end
			open_explorer(path)
		end)
	end,
})

-- セッション復元後にも Explorer を開く。
vim.api.nvim_create_autocmd("SessionLoadPost", {
	group = startup_group,
	desc = "Open Snacks explorer after restoring a session",
	callback = function()
		session_restored = true
		vim.schedule(function()
			open_explorer()
		end)
	end,
})
