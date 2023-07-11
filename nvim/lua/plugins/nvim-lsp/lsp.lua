local common = require('plugins.nvim-lsp.common')

local lspsaga = require('lspsaga')
lspsaga.setup({
    symbol_in_winbar = {
        enable = true
    },
})

local lsp_signature = require('lsp_signature')
local lspconfig = require('lspconfig')
local lsp_setup = function(lsp, opts)
    opts = vim.tbl_deep_extend('force', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function(client, bufnr)
            local opts = { buffer = bufnr }
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', '<leader>gD', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)

            vim.keymap.set('n', '<leader>rn', ':Lspsaga rename<CR>', opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>kk', ':Lspsaga hover_doc<CR>', opts)
            vim.keymap.set({ 'n', 'v', 'i' }, '<F3>', ':Lspsaga outline<CR>', {opts})

            vim.keymap.set('n', '<leader>gl', ':Lspsaga show_buf_diagnostics<CR>', opts)
            vim.keymap.set('n', '<leader>[d', ':Lspsaga diagnostic_jump_prev<CR>', opts)
            vim.keymap.set('n', '<leader>]d', ':Lspsaga diagnostic_jump_next<CR>', opts)

            vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format({async = true}) end, opts)

            lsp_signature.on_attach({
                bind = true,
                handler_opts = {
                    border = 'rounded'
                },
                padding = ' '
            }, bufnr)
        end,
    }, opts or {})
    lspconfig[lsp].setup(opts)
end

for _, v in pairs(common.lsp_mason) do
    lsp_setup(v.lsp, v.lsp_opts)
end
