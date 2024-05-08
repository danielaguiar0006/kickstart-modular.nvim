return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = 'reign_mind',
        path = '~/vaults/reign_mind',
      },
      -- {
      --   name = 'work',
      --   path = '~/vaults/work',
      -- },
    },

    note_id_func = function(title)
      local suffix = ''
      if title ~= nil then
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
          suffix = tostring(os.time()) .. '-' .. suffix
        end
      end
      return suffix
    end,
  },
  config = function(_, opts)
    require('obsidian').setup(opts)
    vim.keymap.set('n', '<leader>of', '<cmd>ObsidianSearch<CR>')
    vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<CR>')
  end,
}
