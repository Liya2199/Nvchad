-- noice.nvim: 重做消息/命令行/通知的 UI (LazyVim 的颜值担当)
-- 效果:
--   `:` 命令行变成底部漂亮的浮窗 (command_palette, 输入时还能看到同类命令)
--   搜索在底部一行 (bottom_search, 而不是中间大浮窗)
--   vim.notify 的通知变成右上角圆角气泡 (nvim-notify, 3 秒消失)
--   长消息自动进 split, 不会糊一脸
--   LSP hover (K) 文档带圆角边框
--
-- 注意 (NvChad 下的坑): NvChad 的 lazy.lua 有 defaults={lazy=true},
-- 插件 spec 必须给 cmd/keys/event 或 lazy=false 才会被加载。
-- noice 用 lazy=false: 命令行从 nvim 启动第一秒就要接管, 懒加载会漏掉开头的命令。
return {
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim", -- neo-tree 已带上, 显式声明更稳
      "rcarriga/nvim-notify",
    },
    opts = {
      -- 让 LSP 的 hover/签名/补全文档走 noice 渲染
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,       -- 搜索放底部一行 (传统 vim 样式)
        command_palette = true,     -- `:` 命令浮窗, LazyVim 同款样式
        long_message_to_split = true, -- 长消息自动进 split
        lsp_doc_border = true,      -- LSP 文档浮窗加圆角边框
      },
      -- NvChad 状态栏自带 LSP 进度显示, 关掉 noice 的避免重复
      routes = {
        {
          filter = { event = "lsp", kind = "progress" },
          view = "mini",
          opts = { skip = true },
        },
      },
    },
    keys = {
      -- 命令行里按 Shift+Enter: 把这条命令的输出送到 Noice 大窗口看 (太长时用)
      {
        "<S-CR>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc = "命令输出重定向到 Noice 窗口",
      },
      -- 关掉右上角所有通知
      {
        "<leader>nd",
        function() require("notify").dismiss { silent = true, pending = true } end,
        desc = "清掉所有通知",
      },
    },
  },

  -- 通知后端: 右上角气泡 (noice 自动把 vim.notify 路由到这里)
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      timeout = 3000,
      render = "compact", -- 同类通知合并, 不堆一屏
      stages = "fade",
    },
  },
}
