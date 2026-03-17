
---@class snacks.dashboard.Config
---@field enabled? boolean
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
return {
	sections = {
		{ section = "header" },
		{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
		{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
		{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
		{ section = "startup" },
	},
	autokeys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
	preset = {
		keys = {
			{ icon = "", desc = "New file", key = "e", action = ":enew" },
			{ icon = "󰒲", desc = "Lazy", key = "z", action = ":Lazy" },
			{ icon = "", desc = "Restore Session", key = "s", section = "session" },
			{ icon = "󰅚", desc = "Quit", key = "q", action = ":qa" },
		},
    header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
	},
}
