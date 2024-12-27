
vim.g.mapleader = " "

vim.keymap.set("n", "[n", ":noh<CR>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
--vim.keymap.set("n", "<C-d>", "<C-d>zz")
--vim.keymap.set("n", "<C-u>", "<C-u>zz")
--vim.keymap.set("n", "n", "nzzzv")
--vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

--next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

--This is going to get me cancelled
--[[vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
--]]

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

--//NOTE: REMAPS FOR FLEXIBLE WINDOWS MANAGEMENT
vim.keymap.set({ "n" }, "<leader>|", ":vsplit<cr>")
vim.keymap.set({ "n" }, "<leader>-", ":split<cr>")

vim.keymap.set({ "n" }, "`|", ":split<CR>:terminal<CR><C-w>Li")
vim.keymap.set({ "n" }, "`-", ":split<CR>:terminal<CR>i")


--//NOTE: REMAPS FOR BETTER TAB MANAGEMENT
vim.keymap.set({ "n" }, "`c", ":tabnew<CR>")
vim.keymap.set({ "n" }, "`l", ":tabnext<CR>")
vim.keymap.set({ "n" }, "`<BS>", ":tabprevious<CR>")
vim.keymap.set({"n"}, "`<leader>", "gt")

local function my_dynamic_mapping(count)
    -- Your logic here using the count
    vim.api.nvim_input(count .. "j") -- Simulate pressing count followed by 'j'
    print("weee")
end
vim.keymap.set({ 'n', 'v' }, ']<count>', '', { noremap = true, expr = true }, function()
    local count = vim.v.count ~= 0 and vim.v.count or ''
    return my_dynamic_mapping(count)
end)

--//NOTE: 7ta nchofo liha chi tkhrija
--vim.keymap.set({"n"}, "<leader>;", ":q<CR>")

--local function cmd(command)
--    return table.concat({ '<Cmd>', command, '<CR>' })
--end

--//NOTE: REMAPS FOR NVIMTREE
vim.keymap.set({"n"}, "<leader>o", ":NvimTreeFindFile<CR>")
