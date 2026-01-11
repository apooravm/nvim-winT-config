local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- Themes
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "AxelGard/oneokai.nvim" },
	{ "rose-pine/neovim", name = "rose-pine" },
	"navarasu/onedark.nvim",
	"Mofiqul/vscode.nvim",

	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- 'xiyaowong/transparent.nvim',

	{ "nvim-treesitter/nvim-treesitter", build = ":tsupdate" },
	"nvim-treesitter/playground",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
	},
	{ "neovim/nvim-lspconfig", lazy = { false } },
	{ "hrsh7th/nvim-cmp" },

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "saadparwaiz1/cmp_luasnip" },

	{ "williamboman/mason.nvim" },
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	-- snippets
	{ "hrsh7th/cmp-buffer" },
	-- vscode like pictograms for funcs, modules, etc.

	-- For folding stuff
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
	},
	{
		"luukvbaal/statuscol.nvim",
	},

	-- vim dev. Gets rid of those annoying warnings anytime I am editing the config
	{ "folke/neodev.nvim", opts = {} },

	-- Temp
	-- working with R in quarto (applied analytics assignment)
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},

	-- Supermaven copilot code completion
	{
		"supermaven-inc/supermaven-nvim",
	},

	-- Minimap
	-- {
	-- 	"gorbit99/codewindow.nvim",
	-- },

	{ "lewis6991/gitsigns.nvim" },

	-- Removed
	{ "vonheikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "onsails/lspkind.nvim" },

	{ "nvim-mini/mini.icons", version = "*" },
}

local opts = {}

require("lazy").setup(plugins, opts)
