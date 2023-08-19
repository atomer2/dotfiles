vim.cmd("colorscheme onedark")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

lualine.setup()
