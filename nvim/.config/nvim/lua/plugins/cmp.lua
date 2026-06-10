-- Autocompletion. See `:help cmp`
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build step needed for regex support in snippets (skipped on Windows).
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				-- {
				--   "rafamadriz/friendly-snippets",
				--   config = function()
				--     require("luasnip.loaders.from_vscode").lazy_load()
				--   end,
				-- },
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),

				-- Tab: accept Copilot inline suggestion, else confirm cmp, else fallback.
				["<Tab>"] = vim.schedule_wrap(function(fallback)
					local copilot_suggestion = require("copilot.suggestion")
					if copilot_suggestion.is_visible() then
						copilot_suggestion.accept()
					elseif cmp.visible() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end),

				["<S-Tab>"] = cmp.mapping.complete({}),

				-- <C-l>/<C-h>: move forward/backward through snippet expansion points.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "copilot" },
				{
					name = "lazydev",
					-- group 0 skips loading LuaLS completions, as lazydev recommends
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},
		})
	end,
}
