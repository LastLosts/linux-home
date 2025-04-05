local function switch_source_header()
    local loc_bufnr = 0
    local clangd_client = nil
    local method_name = "textDocument/switchSourceHeader"

    for _, client in pairs(vim.lsp.get_clients({ bufnr = loc_bufnr })) do
        if client.name == 'clangd' then
            clangd_client = client
        end
    end

    local params = vim.lsp.util.make_text_document_params(loc_bufnr)
    clangd_client.request(method_name, params,
        function(err, result)
            if err then
                error(tostring(err))
            end
            if not result then
                vim.notify('corresponding file cannot be determined')
                return
            end

            vim.cmd.edit(vim.uri_to_fname(result))
        end, local_bufnr)
end

vim.keymap.set("n", "<leader>ss", switch_source_header, {})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.bo[args.buf].formatexpr = nil
        vim.bo[args.buf].omnifunc = nil

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
        vim.keymap.set('n', '<leader>vr', vim.lsp.buf.references, {})

        vim.keymap.set('n', '<leader>ne', function()
            vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR })
        end, { desc = 'Jump to the next Error in the current buffer' })

        vim.keymap.set('n', '<leader>pe', function()
            vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR })
        end, { desc = 'Jump to the previous Error in the current buffer' })
    end,
})

vim.keymap.del('n', 'grn', {})
vim.keymap.del('n', 'gra', {})
vim.keymap.del('n', 'grr', {})
vim.keymap.del('n', 'gri', {})
vim.keymap.del('n', 'gO', {})
