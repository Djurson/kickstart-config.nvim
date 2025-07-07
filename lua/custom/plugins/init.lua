-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { -- File browser
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = { width = 30 },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = { enable = true, update_root = true },
      }
    end,
  },
  { 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons' },
  { -- Project manager
    'coffebar/neovim-project',
    opts = {
      projects = { '~/AppData/Local/nvim/', 'C:/Universitet/*' },
      picker = {
        type = 'telescope', -- or "fzf-lua"
        preview = { enabled = true, git_status = true, git_fetch = true, show_hidden = true },
      },
      datapath = vim.fn.stdpath 'data',
      dashboard_mode = true,
      forget_project_keys = {
        -- insert mode: Ctrl+d
        i = '<C-d>',
        -- normal mode: d
        n = 'd',
      },
      follow_symlinks = 'full',
      session_manager_opts = {
        autosave_ignore_dirs = { vim.fn.expand '~', '/tmp' },
        autosave_ignore_filetypes = { 'ccc-ui', 'gitcommit', 'gitrebase', 'qf', 'toggleterm' },
      },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
      vim.api.nvim_create_autocmd('VimEnter', {
        pattern = '*',
        callback = function()
          if vim.fn.argc() == 0 then
            vim.cmd 'NeovimProjectDiscover'
          end
        end,
      })
    end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      -- optional picker
      { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
      -- optional picker
      { 'ibhagwan/fzf-lua' },
      { 'Shatur/neovim-session-manager' },
    },
    lazy = false,
    priority = 100,
  },
  { 'github/copilot.vim' },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
