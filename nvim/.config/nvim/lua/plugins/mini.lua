-- Collection of small independent modules
return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects (e.g. va) yinq ci')
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (e.g. saiw) sd' sr)')
		require("mini.surround").setup()

		-- Simple statusline
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end
	end,
}
