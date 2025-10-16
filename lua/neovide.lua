
vim.g.neovide_fullscreen = true

--enable zooming in and out at runtime for neovide UI
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.15)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1/1.15)
end)

vim.g.neovide_cursor_trail_size= 0.1
-- vim.g.neovide_cursor_vfx_mode = "pixiedust" 

--//NOTE: testing this config
vim.g.neovide_opacity= 0.9
-- vim.g.neovide_normal_opacity = 0.8
-- vim.g.neovide_background_color = ("#0f1117" .. string.format("%x", math.floor(((255 * vim.g.transparency) or 0.5))))

if vim.g.neovide == true then
    -- vim.cmd 'set guifont=Hack\ NF:h10'
    -- vim.o.guifont='Consolas:h10'
    -- vim.o.guifont='FiraCode NF:h14'
    --vim.o.guifont='Operator Mono,FiraCode NF:h14'
    vim.api.nvim_set_keymap('n', '<F11>', ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end

-- vim.g.neovide_window_blurred = true
