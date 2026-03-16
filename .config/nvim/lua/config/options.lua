-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- file
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand(vim.fn.stdpath("cache") .. "/.vim_backup")
vim.opt.swapfile = false
vim.opt.writebackup = true
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.fenc = "utf-8"
vim.opt.undofile = true

-- appearance
vim.opt.number = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.shortmess:append('I')
vim.opt.virtualedit = 'onemore'
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.winblend = 10
vim.opt.pumblend = 20

-- indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- search and complete
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildmenu = true

-- edit
vim.opt.nrformats:remove({ "unsigned", "octal" })
vim.opt.undolevels = 1000
vim.opt.history = 1000
vim.opt.scrolloff = 4
vim.opt.list = true
vim.opt.listchars = {
	tab = "▸▹┊",
	trail = "▫",
	nbsp = "␣",
	extends = "❯",
	precedes = "❮",
}