require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- 手动格式化(保存时也会自动格式化,这是兜底)
map({ "n", "v" }, "<leader>fm", function()
  require("conform").format { lsp_format = "fallback" }
end, { desc = "格式化当前文件" })

-- <C-s> 保存
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr><esc>", { desc = "保存" })

-- 用 Esc 清掉搜索高亮
map("n", "<Esc>", "<cmd> noh <cr>", { desc = "清除高亮" })

-- 窗口间移动: 交给 vim-tmux-navigator
-- nvim 分屏内部照常切换，到了边缘就自动跳到相邻的 tmux 面板
-- vim 原版: 只有 <C-w>h/j/k/l;  LazyVim/NvChad 惯例: 直接 C-h/j/k/l
--map("n", "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = "左: nvim 窗口 / tmux 面板" })
--map("n", "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = "下: nvim 窗口 / tmux 面板" })
--map("n", "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = "上: nvim 窗口 / tmux 面板" })
--map("n", "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = "右: nvim 窗口 / tmux 面板" })

-- ============ LazyVim 风格补充键位 ============

-- ── 文件树 ──────────────────────────────────────────
-- <leader>e 开/关 neo-tree,再按一次就关 (LazyVim 同款)
-- NvChad 原版: <leader>e 是 NvimTreeFocus、<C-n> 是 NvimTreeToggle(覆盖之,统一用 neo-tree)
--map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "文件树 开/关 (LazyVim)" })
--map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "文件树 开/关 (原 NvimTree)" })

-- ── buffer 切换 / 操作 ─────────────────────────────
-- Shift+h / Shift+l 来回切 buffer (LazyVim 同款)
-- vim 原版: <S-h>=^ 行首、<S-l>=$ 行尾; 改后行首行尾用 0 / g_
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "上一个 buffer (LazyVim)" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "下一个 buffer (LazyVim)" })

-- <leader>b 系列 (NvChad 原版 <leader>b=新建空buffer,移到 <leader>bn; <leader>x=关buffer,加到 <leader>bd)
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "新建空 buffer" })
map("n", "<leader>bd", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "关闭当前 buffer" })
map("n", "<leader>bo", function()
  local t = require "nvchad.tabufline"
  t.closeBufs_at_direction "left"
  t.closeBufs_at_direction "right"
end, { desc = "关闭其他 buffer" })
-- <leader>bb 在最近两个 buffer 间互切 (LazyVim 同款; vim 原版等价键是 <C-^>)
map("n", "<leader>bb", "<C-^>", { desc = "切回上一个 buffer" })

-- ── 窗口操作: <leader>w 等同按下 <C-w>,后面直接接 vim 窗口键 ──
-- 例: <leader>ws 水平分屏  <leader>wv 垂直分屏  <leader>w= 均分  <leader>wo 只留当前
-- (NvChad 原版 <leader>w 是 which-key 帮助键 <leader>wk/wK,保留可用; 保存仍用 C-s)
map("n", "<leader>w", "<C-w>", { remap = true, desc = "+窗口操作 (=C-w)" })
-- 常用的单独列出,which-key 菜单里提示更清楚
map("n", "<leader>wd", "<C-w>c", { remap = true, desc = "关闭窗口 (原 C-w c)" })
map("n", "<leader>ws", "<C-w>s", { remap = true, desc = "水平分屏 (原 C-w s)" })
map("n", "<leader>wv", "<C-w>v", { remap = true, desc = "垂直分屏 (原 C-w v)" })
map("n", "<leader>w=", "<C-w>=", { remap = true, desc = "均分窗口 (原 C-w =)" })
map("n", "<leader>wo", "<C-w>o", { remap = true, desc = "只留当前窗口 (原 C-w o)" })
map("n", "<leader>ww", "<C-w>w", { remap = true, desc = "切下一窗口 (原 C-w w)" })
map("n", "<leader>wm", "<C-w>|<C-w>_", { remap = true, desc = "窗口最大化" })

-- ── 杂项 (LazyVim 习惯) ────────────────────────────
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "插件管理 Lazy (LazyVim)" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "退出 nvim (LazyVim)" })
-- 诊断跳转 (LazyVim 同款; NvChad 原版没有,只有 <leader>ds 打开诊断列表)
map("n", "[d", function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = "上一个诊断" })
map("n", "]d", function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = "下一个诊断" })
