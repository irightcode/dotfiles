-- Set highlight on search
vim.opt.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Disable mouse mode
vim.opt.mouse = 'a'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.wo.signcolumn = 'yes'

-- Set colorscheme
--vim.cmd [[colorscheme onedark]]
vim.cmd.colorscheme "catppuccin"

--vim.cmd()
vim.opt.clipboard = 'unnamedplus'

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Concealer for Neorg
vim.opt.conceallevel=2

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
