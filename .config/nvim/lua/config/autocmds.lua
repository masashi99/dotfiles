local autoread_group = vim.api.nvim_create_augroup("autoread_on_external_change", { clear = true })

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

vim.api.nvim_create_autocmd("FileChangedShell", {
	group = autoread_group,
	desc = "Always reload files changed outside of Neovim without prompting",
	callback = function()
		if vim.v.fcs_reason ~= "deleted" then
			vim.v.fcs_choice = "reload"
		end
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	pattern = "*",
	callback = function()
    vim.opt_local.fo:remove({ "c", "r", "o" })
	end,
	desc = "disable comment in newline",
})
