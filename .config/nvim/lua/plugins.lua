-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	vim.notify("There was a problem while requiring packer")
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single", border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
  use { 'wbthomason/packer.nvim', commit = '1d0cf98a561f7fd654c970c49f917d74fafe1530' } -- Have packer manage itself
  use { 'nvim-lua/plenary.nvim', commit = '253d34830709d690f013daf2853a9d21ad7accab' } -- Requirement for Telescope
  use { 'nvim-tree/nvim-web-devicons', commit = '4709a504d2cd2680fb511675e64ef2790d491d36' }  -- Icons
  use { 'famiu/bufdelete.nvim', commit = '8933abc09df6c381d47dc271b1ee5d266541448e' }

-- GUI 
  use { 'kyazdani42/nvim-tree.lua', -- File explorer
    requires = { 'nvim-tree/nvim-web-devicons' },
    commit = '9c97e6449b0b0269bd44e1fd4857184dfa57bb4c' }
  use { 'akinsho/bufferline.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', 'famiu/bufdelete.nvim' },
    commit = '3677aceb9a72630b0613e56516c8f7151b86f95c'}
  use { 'goolord/alpha-nvim', commit = '4e1c4dedf5983e84b3ed305228b2235c56c7023c' }
  use { 'nvim-lualine/lualine.nvim', commit = 'e99d733e0213ceb8f548ae6551b04ae32e590c80' }
  use { 'arkav/lualine-lsp-progress', commit = '56842d097245a08d77912edf5f2a69ba29f275d7' }
  use { 'akinsho/toggleterm.nvim', commit = '9a595ba699837c4333c4296634feed320f084df2' }

-- Editing support plugins
  use { 'windwp/nvim-autopairs', commit = '6a5faeabdbcc86cfbf1561ae430a451a72126e81' }
  use { 'windwp/nvim-ts-autotag', commit = 'fdefe46c6807441460f11f11a167a2baf8e4534b' }
  use { 'RRethy/vim-illuminate', commit = '49062ab1dd8fec91833a69f0a1344223dd59d643' }
  use { 'numToStr/Comment.nvim', commit = '6821b3ae27a57f1f3cf8ed030e4a55d70d0c4e43' }
  use { 'github/copilot.vim', commit = '9e869d29e62e36b7eb6fb238a4ca6a6237e7d78b' }
  use { 'uga-rosa/ccc.nvim', commit = '9f57ffc78844d18d0991986fbde4dfdf5e839fdd' }

-- Mason related plugins
  use { 'williamboman/mason.nvim', commit = '5b9fd3822d686092c7ee08adfcbd2c764def22c5' } -- LSP Installer
  use { 'williamboman/mason-lspconfig.nvim', -- Filling the gap between lspconfig and mason
    requires = { 'williamboman/mason.nvim' },
    commit = '93e58e100f37ef4fb0f897deeed20599dae9d128' }

-- LSP/Completion plugins
  use { 'neovim/nvim-lspconfig', commit = '91998cef4b1ae3a624901d0f9c894409db24e760' } -- Configurations for Nvim LSP
  use { 'hrsh7th/cmp-nvim-lsp', commit = '0e6b2ed705ddcff9738ec4ea838141654f12eeef' }-- cmp extension for lsp support 
  use { 'hrsh7th/cmp-path', commit = '91ff86cd9c29299a64f968ebb45846c485725f23' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help', commit = '3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1' }
  use { 'hrsh7th/cmp-emoji', commit = '19075c36d5820253d32e2478b6aaf3734aeaafa0' }
  use { 'kdheepak/cmp-latex-symbols', commit = '165fb66afdbd016eaa1570e41672c4c557b57124' }
  use { 'hrsh7th/cmp-nvim-lua', commit = 'f3491638d123cfd2c8048aefaf66d246ff250ca6' }
  use { 'hrsh7th/nvim-cmp', commit = 'ba7a53478d0726683d1597ad1e814695033dcb4b' } -- Completion plugin

-- Snippets related plugins   
  use { 'L3MON4D3/LuaSnip', commit = 'd33cf7de14eea209b8ed4a7edaed72f0b8cedb30' } --snippets
  use { 'saadparwaiz1/cmp_luasnip', --snippets source for cmp using LuaSnip 
    requiers = { 'L3MON4D3/LuaSnip' },
    commit = '18095520391186d634a0045dacaa346291096566' }
  use { 'rafamadriz/friendly-snippets', commit = '6fa50a94ba5378bb73013a6e163376d8e69bd8a5' }

-- Treesitter related plugins
  use { 'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    commit = 'c9d7f9c9207b6fe53f58e0a3ef2e5227c37d9004' }
  use { 'HiPhish/nvim-ts-rainbow2',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    commit = '293e12e90f0928845582b9a3db7258eaa8e92a65' }

-- Telescope
  use { 'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    commit = 'a3f17d3baf70df58b9d3544ea30abe52a7a832c2' }
  use {'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    commit = '580b6c48651cabb63455e97d7e131ed557b8c7e2' }

-- Git
  use { 'lewis6991/gitsigns.nvim', commit = 'b1f9cf7c5c5639c006c937fc1819e09f358210fc' }
  use { 'f-person/git-blame.nvim', commit = '1ad47c6454a5a53d3f4ffdd4022e84f4a6e376cb' }

-- Colorschemes
  use { 'andersevenrud/nordic.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    commit = 'cd552784eeeae61644fec60f6cc52c267dbddc73' }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
