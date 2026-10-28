return {
  -- 关掉 NvChad 自带的 nvim-tree,文件树统一用 neo-tree (LazyVim 同款)
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- 保存时格式化
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- treesitter:补上常用语言的 parser(NvChad 默认只有 lua/vim 几个)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = {
        "lua", "luadoc", "vim", "vimdoc", "printf", "query",
        "bash", "json", "yaml", "toml", "markdown", "markdown_inline",
        "html", "css", "javascript", "typescript", "tsx",
        "python", "regex", "gitcommit", "diff",
      }
      return opts
    end,
  },

  -- ===== 以下是 LazyVim 里习惯用、NvChad 默认没有的 =====

  -- vim-tmux-navigator 暂时禁用(2026-10-27):
  -- nvim/tmux 两侧 zoomed 配置曾互相矛盾导致绑定失效,
  -- 先停用; 窗口切换用纯 vim 的 C-h/j/k/l (见 mappings.lua), 与 tmux 无关
  {
    "christoomey/vim-tmux-navigator",
    enabled = false,
  },

  -- s / S 跳转,比 / 快得多
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash 跳转" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash 选中语法节点" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Flash 远程操作" },
    },
  },

  -- 诊断/引用/符号列表,替代 :copen 和 quickfix
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = { focus = true },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "诊断列表" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "当前文件诊断" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "符号列表" },
      { "<leader>xl", "<cmd>Trouble lsp toggle<cr>", desc = "LSP 引用/定义" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
    },
  },

  -- TODO / FIXME / HACK 高亮
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "搜索 TODO" },
    },
  },

  -- sa 添加环绕 / sd 删除 / sr 替换
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    opts = {},
  },

  -- 增强文本对象:aa 整个文件、ii 缩进块、a? 等等
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = {},
  },

  -- <C-\> 呼出内置终端,LazyVim 的手感
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      -- 关键: 终端内不映射 open_mapping。
      -- 否则在终端里按标准逃生序列 <C-\><C-n>(回普通模式)时,
      -- 第一个 <C-\> 会被拦截直接关掉终端,序列失效。
      -- 关掉后终端内保留: <C-\><C-n>(vim 标准) 和 <C-x>(NvChad 默认) 两种退出方式
      terminal_mappings = false,
      -- 终端内收起终端用 <C-/> (见 mappings.lua), 不占用 <C-\>
      shade_terminals = false,
      start_in_insert = true,
      persist_size = true,
      direction = "float",
      float_opts = { border = "rounded" },
    },
  },
}
