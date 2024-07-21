return {
  -- inc-rename.nvim
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  { -- treesj
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
}
