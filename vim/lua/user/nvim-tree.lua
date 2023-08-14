local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then 
    vim.notify('nvim-tree not found!')
    return
end

nvim_tree.setup(

)
