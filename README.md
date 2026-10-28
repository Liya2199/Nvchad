# 我的 NvChad 配置

基于 [NvChad v3](https://github.com/NvChad/NvChad) + [lazy.nvim](https://github.com/folke/lazy.nvim),
按 [LazyVim](https://www.lazyvim.org/) 的使用习惯补齐了插件和键位。

> NvChad 作为本仓库的一个插件被引入,本仓库只存放覆盖和扩展部分。
> 配置用 git 备份,改动后记得 commit。

## 目录结构

```
lua/
├── plugins/
│   ├── init.lua      # 主插件清单 (文件树/flash/trouble/终端等)
│   ├── lsp.lua       # LSP 服务器 + 格式化工具的自动安装 (mason)
│   ├── noice.lua     # noice.nvim 消息系统 (命令行/通知 UI)
│   ├── neo-tree.lua  # 文件树 (替代 NvChad 自带的 nvim-tree)
│   └── override.lua  # 对 NvChad 自带插件 (tabufline 等) 的微调
├── configs/
│   ├── lspconfig.lua # LSP 服务器配置
│   └── conform.lua   # 格式化器配置
├── mappings.lua      # 全部自定义键位 (带注释,改键来这里)
├── options.lua       # vim 选项
└── chadrc.lua        # NvChad 设置 (主题/状态栏)
```

---

## 插件清单

### NvChad 自带 (核心)

| 插件 | 作用 |
|---|---|
| base46 / ui | 主题引擎 + 状态栏/tabufline/dashboard |
| telescope.nvim | 模糊搜索一切:文件/文本/buffer/帮助 |
| nvim-treesitter | 语法高亮/缩进/选区 (`:TSUpdate` 更新) |
| nvim-cmp + LuaSnip | 补全 + 代码片段 (friendly-snippets) |
| mason.nvim | LSP/linter/formatter 包管理器 |
| conform.nvim | 保存时自动格式化 |
| gitsigns.nvim | 行旁 git 标记 (+/-/~) |
| which-key.nvim | 按 `<leader>` 后弹出键位菜单 |
| nvim-autopairs | 括号自动配对 |
| indent-blankline | 缩进竖线 |
| flash.nvim | `s` 跳转 (LazyVim 同款) |

### 自己加的 (LazyVim 风格)

| 插件 | 作用 | 入口键 |
|---|---|---|
| neo-tree.nvim | 文件树 (替代 nvim-tree,`enabled=false` 关掉了后者) | `<leader>e` |
| flash.nvim | 快速跳转 | `s` / `S` |
| trouble.nvim | 诊断/符号/引用列表 | `<leader>xx` |
| todo-comments.nvim | TODO/FIXME 高亮 + 搜索 | `<leader>ft` |
| mini.surround | 环绕符号操作 | `sa` / `sd` / `sr` |
| mini.ai | 增强文本对象 | `aa` / `ii` / `a)` |
| toggleterm.nvim | 浮窗/分屏终端 | `<C-\>` / `<leader>h` / `<leader>v` |
| noice.nvim | 命令行/消息/通知 UI 重做 | 自动,见下文 |
| nvim-notify | 右上角通知气泡 | 自动 |
| vim-tmux-navigator | tmux 窗格穿透 (当前**已禁用**) | — |

---

## 键位教程

> 任何时候按 `<leader>` 停一秒,which-key 会列出该前缀下所有键。这是最好的学习方式。

### 基础

| 键 | 作用 |
|---|---|
| `jk` (插入模式) | 回到普通模式 |
| `<C-s>` | 保存 |
| `<leader>qq` | 退出 nvim |
| `<Esc>` | 清除搜索高亮 |
| `;` | 进命令行 (等价 `:`) |
| `<leader>l` | 打开插件管理面板 (`:Lazy`) |
| `<leader>fm` | 手动格式化 (保存时也会自动格式化) |

### 文件 & 搜索 (telescope / neo-tree)

| 键 | 作用 |
|---|---|
| `<leader>e` | 文件树开/关 (LazyVim 同款) |
| `<C-n>` | 同上 (NvChad 原键位) |
| `<leader>ff` | 按文件名找文件 |
| `<leader>/` | 全局搜文本内容 (LazyVim 同款) |
| `<leader>fz` | 在当前文件内搜 |
| `<leader>fw` | 全局搜文本 (NvChad 原键位) |
| `<leader>fb` | 列出打开的 buffer |
| `<leader>fo` | 最近打开的文件 |
| `<leader>fh` | 搜 vim 帮助 |
| `<leader>ma` | 搜标记 |
| `<leader>ft` | 搜项目里的 TODO/FIXME/HACK |
| `<leader>gt` | git 变更文件列表 |

### buffer

| 键 | 作用 |
|---|---|
| `<S-h>` / `<S-l>` | 上一个 / 下一个 buffer |
| `<leader>bb` | 在最近两个 buffer 间互切 |
| `<leader>bn` | 新建空 buffer |
| `<leader>bd` | 关闭当前 buffer |
| `<leader>bo` | 关闭其他所有 buffer |

### 窗口

| 键 | 作用 |
|---|---|
| `<C-h/j/k/l>` | 在分屏间移动 (不用先按 `C-w`) |
| `<leader>ws` / `wv` | 水平 / 垂直分屏 |
| `<leader>wd` | 关闭窗口 |
| `<leader>wo` | 只留当前窗口 |
| `<leader>ww` | 切到下一个窗口 |
| `<leader>wm` | 窗口最大化 |
| `<leader>w=` | 均分窗口 |

### 终端 (toggleterm)

| 键 | 作用 |
|---|---|
| `<C-\>` | 呼出/隐藏终端浮窗 (普通模式和终端内都有效) |
| `<C-/>` | 同上 (LazyVim 同款;个别终端发成 `C-_`,同一字节,等效) |
| `<M-i>` | 同上 (备用键) |
| `<leader>tt` | 同上 (别名) |
| `<leader>h` | 横向分屏终端 (15 行) |
| `<leader>v` | 纵向分屏终端 (40% 宽) |
| `<C-\><C-n>` (终端内) | 标准逃生:回到普通模式 |
| `<C-x>` (终端内) | NvChad 默认逃生键 |

> 浮窗、`<leader>h`、`<leader>v` 是三个独立终端实例,各开各关。

### LSP & 诊断

| 键 | 作用 |
|---|---|
| `gd` | 跳到定义 |
| `gr` | 引用列表 |
| `K` | 悬停文档 (noice 渲染,带边框) |
| `<leader>ra` | 重命名符号 |
| `<leader>ca` | Code Action |
| `[d` / `]d` | 上一个 / 下一个诊断 |
| `<leader>ds` | 当前文件诊断列表 (NvChad 原键位) |
| `<leader>xx` | 诊断列表 (trouble,全项目) |
| `<leader>xX` | 诊断列表 (只当前文件) |
| `<leader>xs` | 符号列表 (trouble) |
| `<leader>xl` | LSP 引用/定义位置 (trouble) |
| `<leader>xq` | quickfix 列表 (trouble) |

### 移动 & 文本编辑

| 键 | 作用 |
|---|---|
| `s` | flash 跳转:输入字符,标号跳到任意位置 |
| `S` | flash 语法节点选择 ( Treesitter ) |
| `sa` + 符号 | 添加环绕,如 `sa"` 给当前词加双引号 |
| `sd` + 符号 | 删除环绕 |
| `sr` + 旧新符号 | 替换环绕,如 `sr"'` 双引号换单引号 |
| `aa` | 整个文件作为文本对象 (`vaa` 全选) |
| `ii` | 缩进块作为文本对象 |
| `vap` / `vip` 等 | mini.ai 增强的普通对象也更好用 |

### git (gitsigns)

gitsigns 在行号旁显示 `+`(新增)/`~`(修改)/`_`(删除)。
NvChad 没给它默认键位,常用命令(可先 `:Gitsigns ` 补全):

- `:Gitsigns preview_hunk` — 预览当前改动
- `:Gitsigns stage_hunk` — 暂存当前改动
- `:Gitsigns blame_line` — 查看该行最后一次提交
- `]c` / `[c` — 跳到下一个 / 上一个改动

需要键位的话在 `mappings.lua` 里加。

### 消息 & 通知 (noice.nvim, LazyVim 颜值担当)

| 键/命令 | 作用 |
|---|---|
| `:` | 命令行变成底部浮窗 (输错还带红色提示) |
| `:messages` | 历史消息 (noice 窗口,可搜索) |
| `:Noice` | 完整消息历史面板 (可搜索/过滤) |
| `:Noice last` | 看最近一条消息 |
| `:Noice errors` | 错误消息列表 |
| `<S-CR>` (命令行中) | 把当前命令的输出送进 noice 大窗口看 |
| `<leader>nd` | 清掉右上角所有通知气泡 |

### 主题

`<leader>th` — 打开 NvChad 主题选择器 (base46,几十个主题即开即换)

### 插件 & LSP 管理

| 命令 | 作用 |
|---|---|
| `:Lazy` | 插件面板 (`u` 更新 / `H` 更新日志 / `S` 状态) |
| `:Lazy sync` | 安装 + 更新 + 清理一次做完 |
| `:Mason` | LSP/formatter/linter 安装面板 |
| `:LspInfo` | 查看当前 buffer 挂了哪些 LSP |

---

## 加语言支持

1. `lua/plugins/lsp.lua` → `mason-lspconfig` 的 `ensure_installed` 加服务器名 (如 `"gopls"`)
2. `lua/plugins/init.lua` → treesitter 的 `ensure_installed` 加语言名 (如 `"go"`)
3. 需要格式化就往 `mason-tool-installer` 加,并在 `configs/conform.lua` 注册

## 踩坑记录 (重要)

- **NvChad 的 lazy.nvim 设了 `defaults={lazy=true}`**:新插件 spec 必须给
  `cmd`/`keys`/`event` 或 `lazy=false`,否则插件装了但永远不加载(表现为按键无反应/命令不存在)。
- **不要把 `<leader>w` 直接映射成 `<C-w>`**:会撞 NvChad 自带的 `<leader>wk/wK`(which-key
  帮助键),导致整个窗口菜单错乱。只映射具体的 `<leader>wX` 组合。
- **toggleterm 不要用 `open_mapping`**:它的全局映射要等插件懒加载后才创建,
  首次按键前不存在。开关键统一在 `mappings.lua` 自建。
- **终端内必须保留 `<C-\><C-n>` 标准逃生**,且要在 `<C-\>` 之前显式映射
  (vim 最长匹配优先)。
