require("config.lazy")
require("vim-set")
require("remaps")

vim.diagnostic.config({
    virtual_text = true,
})

vim.lsp.enable({ 'luals', 'clangd' })

vim.cmd[[set cot=menu,menuone,noselect,popup,fuzzy]]

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if (client:supports_method('textDocument/completion')) then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- vim.o.winborder = 'rounded'
