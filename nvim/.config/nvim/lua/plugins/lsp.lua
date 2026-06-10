-- LSP configuration for Neovim 0.12 + mason-lspconfig 2.x.
--
-- The old `mason-lspconfig.setup({ handlers = {...} })` API was removed. Servers
-- are now declared with vim.lsp.config() and enabled via vim.lsp.enable(), which
-- mason-lspconfig does for you (automatic_enable, on by default) for any server
-- it has installed.
return {
	-- Lua LS support for editing your Neovim config (completion, annotations, etc.)
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	{
		"neovim/nvim-lspconfig", -- ships the default server configs in its lsp/ dir
		dependencies = {
			-- NOTE: repos moved from williamboman/* to mason-org/*
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} }, -- LSP progress UI
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Buffer-local setup whenever a language server attaches.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local builtin = require("telescope.builtin")
					map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
					map("gr", builtin.lsp_references, "[G]oto [R]eferences")
					map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					-- Default `K` is remapped to jump-up in config/keymaps.lua, so hover lives here:
					map("<leader>k", vim.lsp.buf.hover, "Hover Documentation")

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					-- Highlight references of the word under the cursor on CursorHold.
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Toggle inlay hints, if the server supports them.
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Advertise nvim-cmp's extra capabilities to every server.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })

			-- Per-server overrides. Add/remove servers here; they merge on top of
			-- nvim-lspconfig's defaults and the "*" capabilities above.
			local servers = {
				clangd = {},
				-- gopls = {},
				pyright = {},
				rust_analyzer = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							-- diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
			}
			for name, cfg in pairs(servers) do
				vim.lsp.config(name, cfg)
			end

			require("mason").setup()

			-- Extra CLI tools (formatters etc.) for Mason to install.
			require("mason-tool-installer").setup({
				ensure_installed = { "stylua", "isort", "black" },
			})

			-- Installs the servers above and auto-enables them (vim.lsp.enable()).
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				automatic_enable = true,
			})
		end,
	},
}
