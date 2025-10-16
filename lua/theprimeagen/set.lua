vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

--vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.api.nvim_set_option('clipboard', 'unnamedplus')

vim.opt.laststatus = 3

vim.o.winblend = 50

function _G.statusLine()
    return vim.g.flutter_tools_decorations.app_version
end

vim.opt.statusline = '%!v:statusLine()'

--vim.opts.rocks.enabled = false
-- Animated smooth scrolling
vim.opt.smoothscroll = true
vim.keymap.set('n', '<ScrollWheelUp>', '5<C-Y>', { noremap = true, silent = true })
vim.keymap.set('n', '<ScrollWheelDown>', '5<C-E>', { noremap = true, silent = true })


 -- blink.cmp  Falling back to Lua implementation due to error while downloading pre-built binary, set fuzzy.implementation to  "prefer_rust"  or  "lua"  to disable this warning. See :messages for details.
