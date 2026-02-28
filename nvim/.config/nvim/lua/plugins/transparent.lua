return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false, -- 起動時から確実に透過させる
    config = function()
      require("transparent").setup({
        -- 標準で透過される要素に加えて、Neo-treeの要素も強制透過の対象に放り込む
        extra_groups = {
          "NeoTreeNormal",
          "NeoTreeNormalNC",
          "NeoTreeWinSeparator",
          "NeoTreeEndOfBuffer",
        },
      })
    end,
  },
}
