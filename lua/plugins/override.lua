-- 上游 NvChad 把 nvim-cmp 的 path 补全源换成了 cmp-async-path,
-- 而它托管在 Codeberg(codeberg.org/FelipeLema/cmp-async-path)。
-- Codeberg 对这台机器频繁返回 429,导致每次启动都重试克隆并失败。
--
-- 这里把同一个仓库改指 GitHub 镜像。注意不能用 jsdelivr:
-- jsdelivr 是 CDN,不是 git 仓库,git clone 必然失败。
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "https://github.com/FelipeLema/cmp-async-path.git",
    },
  },
}
