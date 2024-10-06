-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- BEHAVIOR
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.scrolloff = 10

-- sync clipboard with OS
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- VISUAL
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.cursorline = true

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- case insensiive search #FIXME does not seem to work
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- TODO: figure out what exactly are these for (coppied from kickstart nvim)
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- KEYMAPS
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- switch window focus
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- disable arrow keys in Normal and Visual mode :)
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("v", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("v", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("v", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("v", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- COKELINE
vim.keymap.set("n", "<leader>bp", function()
	require("cokeline.mappings").pick("focus")
end, { desc = "Pick a buffer to focus" })

local map = vim.api.nvim_set_keymap

map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
map("n", "<Leader>p", "<Plug>(cokeline-switch-prev)", { silent = true })
map("n", "<Leader>n", "<Plug>(cokeline-switch-next)", { silent = true })

for i = 1, 9 do
	map("n", ("<F%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
	map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), { silent = true })
end

-- -- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		{
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			},
		},
		-- Useful plugin to show you pending keybinds.
		{
			"folke/which-key.nvim",
			event = "VimEnter",
			opts = {
				icons = {
					mappings = vim.g.have_nerd_font,
					keys = vim.g.have_nerd_font and {} or {
						Up = "<Up> ",
						Down = "<Down> ",
						Left = "<Left> ",
						Right = "<Right> ",
						C = "<C-…> ",
						M = "<M-…> ",
						D = "<D-…> ",
						S = "<S-…> ",
						CR = "<CR> ",
						Esc = "<Esc> ",
						ScrollWheelDown = "<ScrollWheelDown> ",
						ScrollWheelUp = "<ScrollWheelUp> ",
						NL = "<NL> ",
						BS = "<BS> ",
						Space = "<Space> ",
						Tab = "<Tab> ",
						F1 = "<F1>",
						F2 = "<F2>",
						F3 = "<F3>",
						F4 = "<F4>",
						F5 = "<F5>",
						F6 = "<F6>",
						F7 = "<F7>",
						F8 = "<F8>",
						F9 = "<F9>",
						F10 = "<F10>",
						F11 = "<F11>",
						F12 = "<F12>",
					},
				},

				spec = {
					{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
					{ "<leader>d", group = "[D]ocument" },
					{ "<leader>r", group = "[R]ename" },
					{ "<leader>s", group = "[S]earch" },
					{ "<leader>w", group = "[W]orkspace" },
					{ "<leader>t", group = "[T]oggle" },
					{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
				},
			},
		},
		-- Fuzzy Finder (files, lsp, etc)
		{
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			branch = "0.1.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{
					"nvim-telescope/telescope-fzf-native.nvim",

					build = "make",

					cond = function()
						return vim.fn.executable("make") == 1
					end,
				},
				{ "nvim-telescope/telescope-ui-select.nvim" },
				{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			},
			config = function()
				require("telescope").setup({
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown(),
						},
					},
				})

				pcall(require("telescope").load_extension, "fzf")
				pcall(require("telescope").load_extension, "ui-select")

				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
				vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
				vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
				vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
				vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
				vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
				vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
				vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
				vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

				vim.keymap.set("n", "<leader>/", function()
					builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end, { desc = "[/] Fuzzily search in current buffer" })

				vim.keymap.set("n", "<leader>s/", function()
					builtin.live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep in Open Files",
					})
				end, { desc = "[S]earch [/] in Open Files" })

				vim.keymap.set("n", "<leader>sn", function()
					builtin.find_files({ cwd = vim.fn.stdpath("config") })
				end, { desc = "[S]earch [N]eovim files" })
			end,
		},

		-- LSP CONFIG

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
			"neovim/nvim-lspconfig",
			dependencies = {
				{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",

				{ "j-hui/fidget.nvim", opts = {} },

				"hrsh7th/cmp-nvim-lsp",
			},
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
					callback = function(event)
						local map = function(keys, func, desc, mode)
							mode = mode or "n"
							vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end

						--  To jump back, press <C-t>.
						map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

						-- Find references for the word under your cursor.
						map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

						-- Jump to the implementation of the word under your cursor.
						map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

						-- Jump to the type of the word under your cursor.
						map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

						-- Fuzzy find all the symbols in your current document.
						map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

						-- Fuzzy find all the symbols in your current workspace.
						map(
							"<leader>ws",
							require("telescope.builtin").lsp_dynamic_workspace_symbols,
							"[W]orkspace [S]ymbols"
						)

						-- Rename the variable under your cursor.
						map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

						-- Execute a code action, usually your cursor needs to be on top of an error
						map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

						map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if
							client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
						then
							local highlight_augroup =
								vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
								group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
								callback = function(event2)
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({
										group = "kickstart-lsp-highlight",
										buffer = event2.buf,
									})
								end,
							})
						end

						-- This may be unwanted, since they displace some of your code
						if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "[T]oggle Inlay [H]ints")
						end
					end,
				})

				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

				local servers = {
					gopls = {},
					lua_ls = {
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								-- diagnostics = { disable = { 'missing-fields' } },
							},
						},
					},
					azure_pipelines_ls = {
						settings = {
							yaml = {
								schemas = {
									["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
										"/azure-pipeline*.y*l",
										"/*.azure*",
										"Azure-Pipelines/**/*.y*l",
										"Pipelines/*.y*l",
									},
								},
							},
						},
					},
					bashls = {},
					powershell_es = {
						setup = {
							bundle_path = "/opt/powershell_es",
						},
					},
					pylsp = {},
				}
				require("mason").setup()

				local ensure_installed = vim.tbl_keys(servers or {})
				vim.list_extend(ensure_installed, {
					"stylua", -- Used to format Lua code
				})
				require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

				require("mason-lspconfig").setup({
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							require("lspconfig")[server_name].setup(server)
						end,
					},
				})
			end,
		},
		{ -- Autoformat
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				format_on_save = function(bufnr)
					-- Disable "format_on_save lsp_fallback" for languages that don't
					-- have a well standardized coding style. You can add additional
					-- languages here or re-enable it for the disabled ones.
					local disable_filetypes = { c = true, cpp = true }
					local lsp_format_opt
					if disable_filetypes[vim.bo[bufnr].filetype] then
						lsp_format_opt = "never"
					else
						lsp_format_opt = "fallback"
					end
					return {
						timeout_ms = 500,
						lsp_format = lsp_format_opt,
					}
				end,
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform can also run multiple formatters sequentially
					-- python = { "isort", "black" },
					--
					-- You can use 'stop_after_first' to run the first available formatter from the list
					-- javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			},
		},

		{ -- Autocompletion
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				-- Snippet Engine & its associated nvim-cmp source
				{
					"L3MON4D3/LuaSnip",
					build = (function()
						-- Build Step is needed for regex support in snippets.
						-- This step is not supported in many windows environments.
						-- Remove the below condition to re-enable on windows.
						if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
							return
						end
						return "make install_jsregexp"
					end)(),
					dependencies = {
						-- `friendly-snippets` contains a variety of premade snippets.
						--    See the README about individual language/framework/plugin snippets:
						--    https://github.com/rafamadriz/friendly-snippets
						-- {
						--   'rafamadriz/friendly-snippets',
						--   config = function()
						--     require('luasnip.loaders.from_vscode').lazy_load()
						--   end,
						-- },
					},
				},
				"saadparwaiz1/cmp_luasnip",

				-- Adds other completion capabilities.
				--  nvim-cmp does not ship with all sources by default. They are split
				--  into multiple repos for maintenance purposes.
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
			},
			config = function()
				-- See `:help cmp`
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

					-- For an understanding of why these mappings were
					-- chosen, you will need to read `:help ins-completion`
					--
					-- No, but seriously. Please read `:help ins-completion`, it is really good!
					mapping = cmp.mapping.preset.insert({
						-- Select the [n]ext item
						["<C-n>"] = cmp.mapping.select_next_item(),
						-- Select the [p]revious item
						["<C-p>"] = cmp.mapping.select_prev_item(),

						-- Scroll the documentation window [b]ack / [f]orward
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),

						-- Accept ([y]es) the completion.
						--  This will auto-import if your LSP supports it.
						--  This will expand snippets if the LSP sent a snippet.
						["<C-y>"] = cmp.mapping.confirm({ select = true }),

						-- If you prefer more traditional completion keymaps,
						-- you can uncomment the following lines
						--['<CR>'] = cmp.mapping.confirm { select = true },
						--['<Tab>'] = cmp.mapping.select_next_item(),
						--['<S-Tab>'] = cmp.mapping.select_prev_item(),

						-- Manually trigger a completion from nvim-cmp.
						--  Generally you don't need this, because nvim-cmp will display
						--  completions whenever it has completion options available.
						["<C-Space>"] = cmp.mapping.complete({}),

						-- Think of <c-l> as moving to the right of your snippet expansion.
						--  So if you have a snippet that's like:
						--  function $name($args)
						--    $body
						--  end
						--
						-- <c-l> will move you to the right of each of the expansion locations.
						-- <c-h> is similar, except moving you backwards.
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

						-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
						--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
					}),
					sources = {
						{
							name = "lazydev",
							-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
							group_index = 0,
						},
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "path" },
					},
				})
			end,
		},
		{
			"folke/tokyonight.nvim",
			priority = 1000, -- Make sure to load this before all the other start plugins.
			init = function()
				vim.cmd.colorscheme("tokyonight-night")
				vim.cmd.hi("Comment gui=none")
			end,
		},
		-- TODO: check to hightlight on specific words!
		{
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = false },
		},
		-- TODO: Explore this plugin, looks usefull
		{
			"echasnovski/mini.nvim",
			config = function()
				-- Better Around/Inside textobjects
				--
				-- Examples:
				--  - va)  - [V]isually select [A]round [)]paren
				--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
				--  - ci'  - [C]hange [I]nside [']quote
				require("mini.ai").setup({ n_lines = 500 })

				-- Add/delete/replace surroundings (brackets, quotes, etc.)
				--
				-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
				-- - sd'   - [S]urround [D]elete [']quotes
				-- - sr)'  - [S]urround [R]eplace [)] [']
				require("mini.surround").setup()

				-- Simple and easy statusline.
				--  You could remove this setup call if you don't like it,
				--  and try some other statusline plugin
				local statusline = require("mini.statusline")
				-- set use_icons to true if you have a Nerd Font
				statusline.setup({ use_icons = vim.g.have_nerd_font })

				-- You can configure sections in the statusline by overriding their
				-- default behavior. For example, here we set the section for
				-- cursor location to LINE:COLUMN
				---@diagnostic disable-next-line: duplicate-set-field
				statusline.section_location = function()
					return "%2l:%-2v"
				end
			end,
		},
		{ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			main = "nvim-treesitter.configs", -- Sets main module to use for opts
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
			opts = {
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"html",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
				},
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = {
					enable = true,
					-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
					--  If you are experiencing weird indenting issues, add the language to
					--  the list of additional_vim_regex_highlighting and disabled languages for indent.
					additional_vim_regex_highlighting = { "ruby" },
				},
				indent = { enable = true, disable = { "ruby" } },
			},
		},
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
			"willothy/nvim-cokeline",
			dependencies = {
				"nvim-lua/plenary.nvim", -- Required for v0.4.0+
				"nvim-tree/nvim-web-devicons", -- If you want devicons
				"stevearc/resession.nvim", -- Optional, for persistent history
			},
			config = true,
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- -- Tree
-- local function my_on_attach(bufnr)
-- 	local api = require("nvim-tree.api")
--
-- 	local function opts(desc)
-- 		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
-- 	end
--
-- 	-- default mappings
-- 	api.config.mappings.default_on_attach(bufnr)
--
-- 	-- custom mappings
-- 	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
-- 	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
-- end
--
-- -- pass to setup along with your other options
-- require("nvim-tree").setup({
-- 	---
-- 	on_attach = my_on_attach,
-- 	---
-- })
