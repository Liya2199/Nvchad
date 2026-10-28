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

-- ── 终端呼出/隐藏 ───────────────────────
-- 完整键位表 (统一用 toggleterm,不再混用 NvChad 自带的 nvchad.term):
--   <C-\>       呼出/隐藏终端浮窗 (普通模式 + 终端内都能按)
--   <C-/>       同上 (LazyVim 同款; 部分终端把它发成 C-_,同一个字节 0x1f,等效)
--   <M-i>       同上 (Alt+i,备用键)
--   <leader>tt  同上,别名
--   <leader>h   横向分屏终端 (原 NvChad 键走 nvchad.term,与 toggleterm 互不相通、
--               C-\/M-i 都关不掉,所以改为 toggleterm 横向)
--   <leader>v   纵向分屏终端 (同上,改为 toggleterm 纵向)
--   终端内回普通模式: <C-\><C-n> (vim 标准) 或 <C-x> (NvChad 默认)
-- 注意:
--   1. 自建映射而不用 toggleterm 的 open_mapping —— 它要等插件懒加载后才创建,
--      首次按键前不存在(踩过坑)
--   2. t 模式必须先显式映射 <C-\><C-n> 再映射 <C-\>: vim 最长匹配优先,
--      快速连按 <C-\><C-n> 仍是标准逃生; 若 <C-\> 后停顿超过 timeoutlen,
--      才会触发"隐藏终端"
--   3. 浮窗 / <leader>h / <leader>v 是 toggleterm 里三个独立终端实例,各开各关;
--      在某个终端内按键,只会收起当前这一个
map("t", "<C-\\><C-n>", "<C-\\><C-n>", { desc = "终端逃生到普通模式 (标准)" })
map("t", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "隐藏终端 (终端内)" })
map({ "n", "t" }, "<C-/>", "<cmd>ToggleTerm<cr>", { desc = "呼出/隐藏终端" })
map("n", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "呼出/隐藏终端 (NvChad 原版)" })
map({ "n", "t" }, "<M-i>", "<cmd>ToggleTerm<cr>", { desc = "呼出/隐藏终端 (Alt+i)" })
map({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "呼出/隐藏终端" })
map("n", "<leader>h", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", { desc = "终端 横向分屏" })
map("n", "<leader>v", "<cmd>ToggleTerm size=100 direction=vertical<cr>", { desc = "终端 纵向分屏" })

-- 窗口间移动: 纯 vim 方案 (不依赖 tmux)
-- C-h/j/k/l 在 nvim 分屏间移动, 原版行为需先按 C-w, 这个更顺手
-- (tmux 面板间切换用 tmux 原生 C-a 方向键/重复按 C-a)
map("n", "<C-h>", "<C-w>h", { desc = "切到左窗口" })
map("n", "<C-j>", "<C-w>j", { desc = "切到下窗口" })
map("n", "<C-k>", "<C-w>k", { desc = "切到上窗口" })
map("n", "<C-l>", "<C-w>l", { desc = "切到右窗口" })

-- ============ LazyVim 风格补充键位 ============

-- ── 文件树 ──────────────────────────────────────────
-- <leader>e 开/关 neo-tree,再按一次就关 (LazyVim 同款)
-- NvChad 原版: <leader>e 是 NvimTreeFocus、<C-n> 是 NvimTreeToggle
-- (nvim-tree 已禁用,必须覆盖这两个键,否则按了报错)
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "文件树 开/关" })
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "文件树 开/关 (原 NvimTree)" })

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

-- ── 窗口操作 ──
-- 注意: 不要把 <leader>w 直接映射成 <C-w>! 会撞 NvChad 自带的
-- <leader>wk/wK (which-key 帮助键),导致它们行为错乱 —— 上次搞坏的原因之一。
-- 只映射具体的 <leader>wX 组合键, <leader>w 仍作为前缀, which-key 菜单正常。
-- (分屏直接用上面 C-h/j/k/l 或原版 C-w s/v)
map("n", "<leader>wd", "<C-w>c", { remap = true, desc = "关闭窗口" })
map("n", "<leader>ws", "<C-w>s", { remap = true, desc = "水平分屏" })
map("n", "<leader>wv", "<C-w>v", { remap = true, desc = "垂直分屏" })
map("n", "<leader>w=", "<C-w>=", { remap = true, desc = "均分窗口" })
map("n", "<leader>wo", "<C-w>o", { remap = true, desc = "只留当前窗口" })
map("n", "<leader>ww", "<C-w>w", { remap = true, desc = "切下一窗口" })
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

-- <leader>/ 全局搜索文本 (LazyVim 同款; NvChad 原版叫 <leader>fw)
map("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "全局搜索文本" })

-- ── 临时按键诊断 (C-/ 案子查完就删) ──────────────
-- 目的: 抓到终端对 <C-/> 实际发送的字节,确认它到底是不是 0x1f。
-- 用法: 打开 nvim → 普通模式按 2 下 <C-/>、进终端再按 2 下 <C-/> → 告诉助手 → 看 /tmp/nvim_keys.log
do
  local path = "/tmp/nvim_keys.log"
  local f = io.open(path, "a")
  if f then
    f:write(string.format("===== session start %s pid=%d nvim=%s.%s =====\n",
      os.date(), vim.fn.getpid(), vim.version().major, vim.version().minor))
    f:close()
  end
  vim.on_key(function(k)
    local only_printable = true
    for i = 1, #k do
      local b = k:byte(i)
      if b < 32 or b > 126 then
        only_printable = false
        break
      end
    end
    if not only_printable then
      local f2 = io.open(path, "a")
      f2:write(os.date("%H:%M:%S ") .. "mode=" .. vim.api.nvim_get_mode().mode
        .. "  key=" .. vim.fn.keytrans(k)
        .. "  hex=" .. k:gsub(".", function(c) return string.format("%02x ", c:byte()) end)
        .. "\n")
      f2:close()
    end
  end)
end
