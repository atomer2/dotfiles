packer = require 'packer'
packer.init{
  opt_defalut = true,
  display ={
    open_fn= require('packer.util').float,
    show_all_info = true,
    prompt_border = 'double'
  }
}

local use = packer.use
packer.reset()
packer.startup(function()
  use{
    'wbthomason/packer.nvim',
    opt=false
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}}
  }

  --use {"akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
    --require("toggleterm").setup()
  --end}

  use "ravenxrz/DAPInstall.nvim"
  use "ravenxrz/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  use "nvim-telescope/telescope-dap.nvim"
end)

