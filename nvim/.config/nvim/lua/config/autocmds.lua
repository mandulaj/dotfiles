-- [[ Autocommands ]] See `:help lua-guide-autocommands`

-- Highlight on yank. (vim.highlight was deprecated in favour of vim.hl.)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Restore last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Jump to last edit position on opening a file",
	group = vim.api.nvim_create_augroup("last-place", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Trim trailing whitespace on save, but keep the cursor/view put and skip markdown
-- (Markdown uses two trailing spaces as a hard line break).
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Trim trailing whitespace on save",
	group = vim.api.nvim_create_augroup("trim-trailing-ws", { clear = true }),
	callback = function()
		if vim.bo.filetype == "markdown" then
			return
		end
		local view = vim.fn.winsaveview()
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})
