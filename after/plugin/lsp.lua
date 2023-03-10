local lsp = require('lsp-zero')
-- Setup neovim lua configuration
require('neodev').setup()

-- Turn on lsp status information
require('fidget').setup()
lsp.preset('recommended')

lsp.ensure_installed({
	'sumneko_lua',
	'gopls',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			},
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		}
	}
})

local cmp = require 'cmp'
local luasnip = require 'luasnip'

local cmp_select = { behavior = cmp.SelectBehavior.Select }
lsp.setup_nvim_cmp({
	mapping = lsp.defaults.cmp_mappings({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	})
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I'
	}
})

lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.name == "eslint" then
		vim.cmd.LspStop('eslint')
		return
	end

	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
	-- vim.keymap.set('n', '<leader>ld', tb.diagnostics, vim.tbl_deep_extend('force',{severity=vim.diagnostic.severity.ERROR}, opts))

end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
