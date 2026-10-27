local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },

    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
  },

  -- 保存时格式化;没有配 formatter 的语言退回 LSP 格式化
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options
