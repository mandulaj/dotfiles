-- nvim-treesitter MAIN branch -- required for Neovim 0.12 (the old `master`
-- branch is frozen/archived and breaks on 0.12).
--
-- This is effectively a different plugin from the old setup:
--   * no require("nvim-treesitter.configs").setup()
--   * no ensure_installed / highlight / indent / auto_install opts
--   * parsers are installed explicitly and highlighting is started per-buffer
--
-- Requires the `tree-sitter` CLI on your PATH plus a C compiler to build parsers.
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"bash",
			"c",
			"cpp",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"vim",
			"vimdoc",
			"latex",
		}
		-- Installs any missing parsers (async; compiles on first run).
		require("nvim-treesitter").install(parsers)

		-- Treesitter indentation is still experimental on the main branch; keep it
		-- off for filetypes where it tends to misbehave (matches your old config).
		local indent_disable = { ruby = true, python = true, c = true, cpp = true }

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
			callback = function(ev)
				-- Start highlighting; pcall makes it a no-op when no parser exists.
				pcall(vim.treesitter.start)

				if not indent_disable[vim.bo[ev.buf].filetype] then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
