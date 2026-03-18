-- clipboard copy
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y', { desc = 'MacOS copy' })

-- split window
vim.keymap.set('n', '<Leader>s', ':<C-u>sp\n', { noremap = true })
vim.keymap.set('n', '<Leader>v', ':<C-u>vs\n', { noremap = true })

-- move window
vim.keymap.set('n', '<Leader>j', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>k', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>l', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>h', '<C-w>h', { noremap = true, silent = true })

-- close window
vim.keymap.set('n', '<Leader>w', '<C-w>c', { noremap = true })
vim.keymap.set('n', '<Leader>h', '<C-w>h', { noremap = true, silent = true })

-- tab management
vim.keymap.set('n', '<tab>', '<cmd>tabnext<cr>', { silent = true })
vim.keymap.set('n', '<s-tab>', '<cmd>tabprevious<cr>', { silent = true })
vim.keymap.set('n', '<leader>t', '<cmd>tabe .<cr>', { silent = true })
vim.keymap.set('n', '<leader>c', '<cmd>tabclose<cr>', { silent = true })

-- terminal mode
vim.keymap.set('n', '<leader>t', ':terminal<CR>')
vim.keymap.set('t', '<C-k>', [[<C-\><C-n>]])

-- command mode
--- Emacs style
vim.keymap.set('c', '<C-a>', '<Home>', { silent = false })
vim.keymap.set('c', '<C-e>', '<End>', { silent = false })

-- delete without yank
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
-- delete to end of line without yank
vim.keymap.set({ 'n', 'v' }, 'X', '"_d$') 
-- close quickfix
vim.keymap.set({ 'n', 'v' }, '<leader>x', vim.cmd.cclose)
-- clear search highlight
vim.keymap.set('n', '<leader>q', '<cmd>nohlsearch<cr><esc>')
-- redo by Uj
vim.keymap.set('n', 'U', '<C-r>')
-- {visual}p to put without yank to unnamed register https://github.com/Shougo/shougo-s-github/blob/21a3f500cdc2b37c8d184edbf640d9e17458358a/vim/rc/mappings.rc.vim#L190-L191
vim.keymap.set('x', 'p', 'P') 

-- indent in visual mode
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')
