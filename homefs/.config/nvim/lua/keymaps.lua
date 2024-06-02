-- move
vim.keymap.set('i', '<C-h>', '<left>')
vim.keymap.set('i', '<C-j>', '<down>')
vim.keymap.set('i', '<C-k>', '<up>')
vim.keymap.set('i', '<C-l>', '<right>')

vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set({ 'n', 'v' }, 'J', '10j')
vim.keymap.set({ 'n', 'v' }, 'K', '10k')
vim.keymap.set({ 'n', 'v' }, 'W', 'b')
vim.keymap.set({ 'n', 'v' }, 'E', 'ge')

-- copy, cut, delete
vim.keymap.set('v', '<C-x>', '"+x')
vim.keymap.set('v', '<C-d>', '"+d')
vim.keymap.set('v', '<C-y>', '"+y')
vim.keymap.set('n', '<C-p>', '"+p')

vim.keymap.set('n', 'dL', 'd$')
vim.keymap.set('n', 'dH', 'd0')

-- window
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', 'sp', '<C-w>s')
vim.keymap.set('n', 'vs', '<C-w>v')

-- exit
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>')
vim.keymap.set('n', '<leader>qq', '<cmd>wq<CR>')
vim.keymap.set('n', '<leader>qa', '<cmd>wqa<CR>')

-- misc
vim.keymap.set({ 'n', 'v', 'i' }, '<up>', '<nop>')
vim.keymap.set({ 'n', 'v', 'i' }, '<down>', '<nop>')
vim.keymap.set({ 'n', 'v', 'i' }, '<left>', '<nop>')
vim.keymap.set({ 'n', 'v', 'i' }, '<right>', '<nop>')
