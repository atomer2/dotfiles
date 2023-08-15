local packer = require 'packer'
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

  use 'akinsho/toggleterm.nvim'
  use 'ravenxrz/DAPInstall.nvim'
  use 'ravenxrz/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'rcarriga/nvim-dap-ui'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'mhinz/vim-startify'
  use  {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt=true}
  }
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'windwp/nvim-autopairs'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use {
      'nvim-treesitter/nvim-treesitter',
      -- run = ':TSUpdate', 
  }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig'
  use 'olimorris/onedarkpro.nvim'
  use 'scrooloose/nerdcommenter'
end)

