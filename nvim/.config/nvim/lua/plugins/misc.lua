-- Small standalone plugins
return {
	"tpope/vim-sleuth", -- auto-detect tabstop/shiftwidth
	"ThePrimeagen/vim-be-good",
	{ "nvim-treesitter/nvim-treesitter-context", event = "BufReadPost" },
}
