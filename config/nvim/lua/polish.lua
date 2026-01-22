-- Enable Neovim LSP 
vim.lsp.enable({ "gopls" })
-- Go: format on save (gopls)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "go.mod", "go.sum", "go.work" },
  callback = function(args)
    vim.lsp.buf.format { bufnr = args.buf, timeout_ms = 2000 }
  end,
})
-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
