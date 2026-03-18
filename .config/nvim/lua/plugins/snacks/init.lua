---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  init = function()
		vim.api.nvim_create_user_command("Bdelete", function()
			Snacks.bufdelete()
		end, { nargs = 0 })
		vim.api.nvim_create_user_command("Bdeleteall", function()
			Snacks.bufdelete.all()
		end, { nargs = 0 })
		vim.api.nvim_create_user_command("Lazygit", function()
			Snacks.lazygit()
		end, { nargs = 0 })
  end,
  keys = {
    -- Dashboard [[
    {
			"<leader>d",
			function()
				Snacks.dashboard()
			end,
			desc = "Dashboard",
		},
    -- Dashboard ]]
		-- Explorer [[
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer"
		},	
		-- Explorer ]]
		-- Picker [[
		{
			",<cr>",
			function()
				Snacks.picker.picker_actions()
			end,
			desc = "Picker Actions",
		},
    {
      ",<space>",
      function()
        Snacks.picker.grep({
          hidden = true,
        })
      end,
      desc = "Grep",
    },
    {
			",b",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Buffers",
		},
    {
			",s",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Grep String",
			mode = { "n", "x" },
		},
    {
			",P",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
    {
			",B",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
    {
			",C",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorscheme",
		},
    {
			",f",
			function()
				Snacks.picker.files({
					hidden = true,
				})
			end,
			desc = "Find Files",
		},
    {
			",g",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
    {
			",h",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			",j",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumplist",
		},
    {
			",l",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Lazy",
		},
    {
			",m",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			",c",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
    {
			",q",
			function()
				Snacks.picker.qflist()
			end,
			desc = "qflist",
		},
    {
			",r",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
    {
			",t",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "TODO",
		},
		{
			",i",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
    {
			",z",
			function()
				Snacks.picker.zoxide()
			end,
			desc = "Zoxide",
		},
		{
			",d",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
		},
		{
			",D",
			function()
				Snacks.picker.diagnostics()
			end,
		},
    -- Picker ]]
    -- lazygit [[
		{
			"<leader>g",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
    {
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Log File",
		},
		-- lazygit ]]
  },
  ---@type snacks.Config
  opts = {
    input = { enabled = true },
    picker = {
      ui_select = true,
      formatters = {
        file = {
          filename_first = true,
          truncate = 400,
        },
      },
			hidden = true,
    },
    bigfile = { enabled = true },
    dashboard = require('plugins.snacks.dashboard'),
    lazygit = { enabled = true },
    explorer = {
			enabled = true,
		},
    indent = {
      enabled = true,
      animate = {
        enabled = false
      }
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
