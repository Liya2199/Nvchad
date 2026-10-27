-- LSP 与外部工具的自动安装
-- mason-lspconfig v2 会在安装完成后自动调用 vim.lsp.enable()
return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      -- 想加语言就往下加服务器名,:Mason 里能看到全部可选项
      ensure_installed = {
        "lua_ls",     -- Lua / 这个配置文件本身
        "bashls",     -- Shell
        "jsonls",     -- JSON
        "yamlls",     -- YAML
        "html",       -- HTML
        "cssls",      -- CSS
        "pyright",    -- Python
        "ts_ls",      -- JS / TS
        -- "clangd",   -- C / C++,50MB,需要时取消注释
        -- "rust_analyzer",
        -- "gopls",
      },
      automatic_enable = true,
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- 格式化器 / linter,conform 会自动用 mason 装好的二进制
      ensure_installed = {
        "stylua",   -- lua
        "prettier", -- js/ts/css/html/json/yaml/md
        "shfmt",    -- shell
      },
      run_on_start = true,
    },
  },
}
