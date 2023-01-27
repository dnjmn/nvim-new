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
	-- colorschemes
	use 'navarasu/onedark.nvim' -- Theme inspired by Atom
	use 'folke/tokyonight.nvim'
	use 'fatih/molokai'
	use 'luisiacc/gruvbox-baby'
	use {
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	}

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
	use 'mbbill/undotree'


	-- FUNCTIONS
	-- buffer line
	use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
	use 'moll/vim-bbye'

	-- file explorer
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', opt = true -- optional, for file icons
		},
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
	-- terminal
	use { "akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup()
	end }
	-- git
	use 'lewis6991/gitsigns.nvim'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'

	use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
	-- comment
	use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines

	-- VISUALS
	use 'nvim-lualine/lualine.nvim' -- status line
	use 'karb94/neoscroll.nvim' -- smooth scrolling
	use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
	use "folke/zen-mode.nvim" -- zenmode

	if is_bootstrap then
		require('packer').sync()
	end
end)
