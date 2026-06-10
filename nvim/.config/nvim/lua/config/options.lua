-- [[ Editor options ]] See `:help vim.opt` and `:help option-list`

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"
vim.opt.showmode = false

-- Sync clipboard with the OS. Scheduled to avoid increasing startup time.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250

-- 1000 is the default. Lower this (e.g. 300) if you want the which-key popup sooner.
vim.opt.timeoutlen = 1000

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 20

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Treat certain ssh files as sshconfig
vim.filetype.add({
	pattern = {
		[".ssh/config"] = "sshconfig",
		[".ssh/config%.d/.*"] = "sshconfig",
		[".ssh/hosts/.*"] = "sshconfig",
	},
})
