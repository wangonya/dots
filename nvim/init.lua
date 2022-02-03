-------------------- helpers -------------------------------
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then scopes["o"][key] = value end
end

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = " "
g.maplocalleader = ","
--------------------------------------------------------------

-------------------- plugins -------------------------------
cmd [[packadd packer.nvim]]
cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua
require("packer").startup(function()
    use {"wbthomason/packer.nvim", opt = true}
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip", "hrsh7th/vim-vsnip-integ",
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline", "rafamadriz/friendly-snippets"
        }
    }
    use "neovim/nvim-lspconfig"
    use "wakatime/vim-wakatime"
    use "nvim-treesitter/nvim-treesitter"
    use "lukas-reineke/format.nvim"
    use "mhinz/vim-signify"
    use "b3nj5m1n/kommentary"
    use "jiangmiao/auto-pairs"
    use "f-person/git-blame.nvim"
    use "nvim-lualine/lualine.nvim"
    use "akinsho/nvim-bufferline.lua"
    use "Mofiqul/dracula.nvim"
end)
--------------------------------------------------------------

-------------------- colorscheme -------------------------------
vim.cmd [[colorscheme dracula]]
--------------------------------------------------------------

-------------------- key mappings -------------------------------
map("n", "<leader>hl", "<cmd>noh<cr>") -- Clear highlights
map("i", "jk", "<Esc>") -- jk to escape
map("n", "<leader>w", "<cmd>wa<cr>") -- save
map("n", "<leader>q", "<cmd>q<cr>") -- quit
map("n", "<leader>t", "<cmd>WakaTimeToday<CR>") -- wakatime
map("n", "<leader>bd", "<cmd>bd<CR>") -- delete buffer

-- copy cut paste
map("v", "<C-c>", [["+y]])
map("v", "<C-x>", [["+x]])
map("v", "<C-p>", [["+gP]])

-- moving between splits
map("n", "<C-J>", "<C-W><C-J>")
map("n", "<C-K>", "<C-W><C-K>")
map("n", "<C-L>", "<C-W><C-L>")
map("n", "<C-H>", "<C-W><C-H>")

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

-- session
map("n", "<Leader>ss", "<cmd>mksession! .session.vim<cr>")
map("n", "<Leader>sl", "<cmd>source .session.vim<cr>")

-- term
map("n", "<Leader>tt", "<cmd>term<cr>")
map("n", "<Leader>ht", "<cmd>sp term://zsh<cr>")
map("n", "<Leader>vt", "<cmd>vsp term://zsh<cr>")
map("t", "<Esc>", "<C-\\><C-n>") -- jk to escape
--------------------------------------------------------------

-------------------- options -------------------------------
opt("b", "expandtab", true) -- Use spaces instead of tabs
opt("b", "shiftwidth", 4) -- Size of an indent
opt("b", "smartindent", true) -- Insert indents automatically
opt("b", "tabstop", 4) -- Number of spaces tabs count for
opt("o", "completeopt", "menuone,noselect") -- Completion options
opt("o", "hidden", true) -- Enable modified buffers in background
opt("o", "ignorecase", true) -- Ignore case
opt("o", "joinspaces", false) -- No double spaces with join after a dot
opt("o", "mouse", "a") -- Allow mouse
opt("o", "signcolumn", "yes")
opt("o", "updatetime", 100)
opt("o", "shiftround", true) -- Round indent
opt("o", "smartcase", true) -- Don't ignore case with capitals
opt("o", "splitbelow", true) -- Put new windows below current
opt("o", "splitright", true) -- Put new windows right of current
opt("w", "list", true)
opt("w", "listchars", "tab:»·,trail:·,nbsp:·")
opt("o", "termguicolors", true) -- True color support
opt("o", "wildmode", "list:longest") -- Command-line completion mode
opt("o", "wildmenu", true)
opt("w", "number", true) -- Print line number
opt("w", "relativenumber", true) -- Relative line numbers
cmd "au TextYankPost * lua vim.highlight.on_yank {on_visual = false}" -- highlight on yank
cmd "au BufRead,BufNewFile *.md,*.mdx,*.txt,*.rst setlocal spell" -- always set spell on for .md,txt,mdx,rst files
cmd "au FocusLost * :wa" -- autosave on lose focus

-- jump to the last position when reopening a file
cmd [[au BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
--------------------------------------------------------------

---------------------- telescope ---------------------------------
require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "respect_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}
require('telescope').load_extension('fzf')
--------------------------------------------------------------

---------------------- git blame ---------------------------------
g.gitblame_date_format = "%r"
------------------------------------------------------------------

---------------------- completions (nvim-cmp) --------------------------
local cmp = require "cmp"

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "s"}),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        ["<C-leader>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ["<CR>"] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "vsnip"}},
                                 {{name = "buffer"}})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})
})
--------------------------------------------------------------

---------------------- lsp ---------------------------------
local nvim_lsp = require('lspconfig')
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>gi',
                   '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>wa',
                   '<cmd>lua vim.lsp.buf.add_workleader_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr',
                   '<cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>',
                   opts)
    buf_set_keymap('n', '<leader>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>',
                   opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

nvim_lsp.pylsp.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    settings = {
        pylsp = {
            configurationSources = {"flake8"},
            plugins = {
                flake8 = {enabled = true, config = "~/dots/python/flake8"},
                pycodestyle = {enabled = false},
                pyflakes = {enabled = false},
                pylint = {enabled = false},
                yapf = {enabled = false}
            }
        }
    }
}

nvim_lsp.pyright.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    cmd = {"pyright-langserver", "--stdio"},
    filetypes = {"python"},
    settings = {
        python = {
            disableOrganizeImports = true,
            analysis = {
                typeCheckingMode = "off",
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly"
            }
        }
    },
    single_file_support = true
}

nvim_lsp.gopls.setup {on_attach = on_attach}
nvim_lsp.eslint.setup {on_attach = on_attach}

--------------------------------------------------------------

---------------------- autoformat ---------------------------------
require"format".setup {
    ["*"] = {
        {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whiteleader
    },
    python = {{cmd = {"darker -i"}}},
    go = {{cmd = {"gofmt -w", "goimports -w"}, tempfile_postfix = ".tmp"}},
    javascript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
    javascriptreact = {
        {cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}
    },
    ["javascript.jsx"] = {
        {cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}
    },
    typescript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
    typescriptreact = {
        {cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}
    },
    ["typescript.tsx"] = {
        {cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}
    },
    vue = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
    html = {{cmd = {"prettier -w"}}},
    css = {{cmd = {"prettier -w"}}},
    scss = {{cmd = {"prettier -w"}}},
    lua = {
        {
            cmd = {
                function(file)
                    return string.format("lua-format -i %s", file)
                end
            }
        }
    },
    markdown = {
        {cmd = {"prettier -w"}}, {
            cmd = {"black"},
            start_pattern = "^```python$",
            end_pattern = "^```$",
            target = "current"
        }
    }
}

vim.api.nvim_exec([[
augroup Format
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END
]], true)
--------------------------------------------------------------

-------------------- tree-sitter ---------------------------
require"nvim-treesitter.configs".setup {
    ensure_installed = {
        "bash", "css", "go", "html", "json", "lua", "python", "rst", "tsx",
        "typescript", "yaml"
    },
    highlight = {enable = true}
}
--------------------------------------------------------------

-------------------- bufferline -------------------------------
require"bufferline".setup {
    options = {
        view = "multiwindow",
        diagnostic = "nvim_lsp",
        separator_style = "thin",
        numbers = "ordinal",
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false
    }
}
--------------------------------------------------------------

-------------------- lualine -------------------------------
require"lualine".setup {
    options = {
        icons_enabled = false,
        theme = "dracula-nvim",
        component_separators = "|",
        section_separators = {left = "", right = ""},
        disabled_filetypes = {},
        always_divide_middle = true
    },
    sections = {
        lualine_a = {},
        lualine_b = {
            "branch", "diff", {"diagnostics", sources = {"nvim_diagnostic"}}
        },
        lualine_c = {{"filename", path = 1}},
        lualine_x = {"progress"},
        lualine_y = {"location"},
        lualine_z = {}
    }
}
--------------------------------------------------------------
