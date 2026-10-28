-- lua/plugins/neo-tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  -- 必须保留: configs/lazy.lua 里 defaults={lazy=true}, 去掉这个 cmd 就既不会
  -- 懒加载也不会启动加载,插件永远不加载,<leader>e 报 E492 Not an editor command
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    -- press H to show/hide files
    open_files_in_last_window = true,
    filesystem = {
      group_empty_dirs = true,
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        -- Show dotfiles/dotfolders(.gitignore .env .git .venv)
        hide_dotfiles = false,
        hide_gitignored = false, -- 原来拼成 high_giutignored,是无效键,修正为 false(不隐藏 gitignored)
        hide_by_name = { "node_modules", "dist", "__pycache__" },
      },
    },
  },
}
