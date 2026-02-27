return {
  -- 1. Catppuccinの導入と透過設定
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- Ghosttyと同じ暗色テーマ
      transparent_background = true, -- ここで透過させる
    },
  },
  -- 2. LazyVimのデフォルトテーマをCatppuccinに変更
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
