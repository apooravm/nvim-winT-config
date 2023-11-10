-- Installing Packer with Bootstrapping funcs
-- Checks if packer installed
-- If not, installs it

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    local git_installed = io.popen('where git'):read('*l')
    if not git_installed then
      print('Git is not installed. Please install Git.')
      return false
    end

    local git_clone_command = string.format('git clone --depth 1 https://github.com/wbthomason/packer.nvim %s', install_path)
    os.execute(git_clone_command)

    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Your plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  use 'navarasu/onedark.nvim'
  use 'Mofiqul/vscode.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'xiyaowong/transparent.nvim'

  use 'nvim-treesitter/nvim-treesitter'
  use {
	  'nvim-telescope/telescope.nvim',
	  tag = '0.1.0',
	  requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
