require('plugins.nvim-cmp.lsp')

local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load()

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
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
        -- ['<Tab>'] = cmp.mapping.select_next_item(),
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<A-k>'] = cmp.mapping.scroll_docs(-4),
        ['<A-j>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm(),
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = string.format('%s', vim_item.kind)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                emoji = "[Emoji]",
                path = "[Path]",
                buffer = "[Buffer]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'emoji' },
        { name = 'path' },
        { name = 'buffer' },
    }),
    sorting = {
        comparators = { cmp.config.compare.exact, cmp.config.compare.offset }
    },
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'buffer' }
    })
})
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'cmdline' }
    })
})
