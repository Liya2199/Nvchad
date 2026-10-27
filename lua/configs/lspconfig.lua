require("nvchad.configs.lspconfig").defaults()

-- mason-lspconfig 会自动 vim.lsp.enable() 所有通过 mason 装好的服务器,
-- 所以这里不需要再列一遍。想单独给某个服务器加配置,这样写:
--
--   vim.lsp.config("pyright", {
--     settings = { python = { analysis = { typeCheckingMode = "basic" } } },
--   })
--
-- 想禁用某个已装好的服务器:
--   vim.lsp.enable("clangd", false)
