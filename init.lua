vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- 兼容垫片 (2026-10-28):
-- NvChad ui 新版 colorify 直接调用 vim.lsp.document_color.enable(false),
-- 但这个 API 是 nvim 0.12 才有的, 0.11.3 下报 attempt to index nil。
-- 补一个空实现让调用变成 no-op; 升级到 0.12 后检测不到此条件, 自动失效。
if not vim.lsp.document_color then
  vim.lsp.document_color = { enable = function() end }
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
