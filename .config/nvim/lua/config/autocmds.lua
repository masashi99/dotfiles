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

