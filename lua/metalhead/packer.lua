-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
	vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim'

	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },
			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },
			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
			-- Useful status updates for LSP
			'j-hui/fidget.nvim',
			-- Additional lua configuration, makes nvim stuff amazing
			'folke/neodev.nvim',
		}
	}

	-- Highlight, edit, and navigate code
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	}
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
	use { 'mbbill/undotree' }


	-- FUNCTIONS
	-- terminal
	use { "akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup()
	end }
	-- git
	use { 'lewis6991/gitsigns.nvim' }
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'

	use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
	-- comment
	use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines

	-- VISUALS
	-- colorschemes
	use 'navarasu/onedark.nvim' -- Theme inspired by Atom
	use {
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	}
	-- lualine
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	-- scrolling
	use { 'karb94/neoscroll.nvim' }
	-- Add indentation guides even on blank lines
	use 'lukas-reineke/indent-blankline.nvim'
	-- zenmode
	use { "folke/zen-mode.nvim" }

	if is_bootstrap then
		require('packer').sync()
	end
end)
