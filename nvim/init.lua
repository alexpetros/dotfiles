-- Load vimscript stuff
vim.cmd("set runtimepath^=~/.vim runtimepath+=~/.vim/after")
vim.cmd("let &packpath = &runtimepath")
vim.cmd("source ~/.config/nvim/vimrc")

vim.opt.mouse=""

-- Setup lsp
vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            check = {
              command = "clippy",
              ignore = { "unused_imports" }
            },
            diagnostics = { enable = true },
            imports = {
              granularity = { group = "item" }
          }
        }
    }
})
vim.lsp.enable('rust_analyzer')

vim.lsp.enable('ts_ls')

-- vim.lsp.enable('gopls')

vim.diagnostic.config({ virtual_text = false })
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Set up pop-up completions
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
  })
})


-- Requires separate installation of the tree-sitter CLI
require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to
  -- It's ~/.local/share/nvim/site on my mac
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require('nvim-treesitter').install {
  "vim", "vimdoc", "query", "rust", "javascript", "typescript", "css",
  "html", "go", "templ", "lua", "prolog"
}

require("nvim-treesitter-textobjects").setup {
  select = {
    enable = true,

    lookahead = true, -- Automatically jump forward to textobj
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V', -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
    include_surrounding_whitespace = true,
  },
  swap = {
    enable = true,
    swap_next = {
      ["<leader>pj"] = "@parameter.inner",
      ["<leader>fj"] = "@function.outer",
    },
    swap_previous = {
      ["<leader>pk"] = "@parameter.inner",
      ["<leader>fk"] = "@function.outer",
    },
  },
}

local to_select = require "nvim-treesitter-textobjects.select".select_textobject
local to_swap_next = require "nvim-treesitter-textobjects.swap".swap_next
local to_swap_previous = require "nvim-treesitter-textobjects.swap".swap_previous

local function set_to_keymap (keymap, func, textobject)
  vim.keymap.set({ "x", "o" }, keymap, function()
    func(textobject, "textobjects")
  end)
end

local function set_normal_keymap (keymap, func, textobject)
  vim.keymap.set('n', keymap, function()
    func(textobject, "textobjects")
  end)
end

set_to_keymap("af", to_select, "@function.outer")
set_to_keymap("if", to_select, "@function.inner")
set_to_keymap("ar", to_select, "@parameter.outer")
set_to_keymap("ir", to_select, "@parameter.inner")
set_to_keymap("ac", to_select, "@class.outer")
set_to_keymap("ic", to_select, "@class.inner")
set_to_keymap("as", to_select, "@scope.outer")
set_normal_keymap("<leader>rj", to_swap_next, "@parameter.inner")
set_normal_keymap("<leader>fj", to_swap_next, "@function.outer")
set_normal_keymap("<leader>rk", to_swap_previous, "@parameter.inner")
set_normal_keymap("<leader>fk", to_swap_previous, "@function.outer")


local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    -- path_display = { "smart" },
    file_ignore_patterns = { "vendor/*" },
    mappings = {
      i = {
        ["<Esc>"] = nil
      },
    },
  },
  pickers = {
    find_command = { "rg", "--files", "--color", "never", "--hidden", "--glob", "!.git" },
    live_grep = { additional_args = { "--hidden", "--glob", "!.git" } },
  }
})

require('telescope').load_extension('heading')

-- TODO add "-->" pattern
require('mini.align').setup()
