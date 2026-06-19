-- Small standalone plugins
return {
	"tpope/vim-sleuth", -- auto-detect tabstop/shiftwidth
	"ThePrimeagen/vim-be-good",
	{ "nvim-treesitter/nvim-treesitter-context", event = "BufReadPost" },
	{
		"nvim-mini/mini.pairs",
		event = "InsertEnter", -- Lazy loads the plugin only when you enter insert mode
		opts = {},
		-- opts = {
		-- 	modes = { insert = true, command = true, terminal = false },
		-- 	-- skip autopair when next character is one of these
		-- 	skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
		-- 	-- skip autopair when the cursor is inside these treesitter nodes
		-- 	skip_ts = { "string" },
		-- 	-- skip autopair when next character is closing pair
		-- 	-- and there are more closing pairs than opening pairs
		-- 	skip_unbalanced = true,
		-- 	-- better deal with markdown code blocks
		-- 	markdown = true,
		-- },
	},
}
