-------------------- helpers -------------------------------
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = " "
g.maplocalleader = ","
--------------------------------------------------------------

-------------------- plugins -------------------------------
cmd [[packadd packer.nvim]]
cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua
require("packer").startup(
    function()
        use {"wbthomason/packer.nvim", opt = true}
        use {
            "akinsho/nvim-bufferline.lua",
            requires = "kyazdani42/nvim-web-devicons"
        }
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
        }
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-vsnip",
                "hrsh7th/vim-vsnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline"
            }
        }
        use {
            "kyazdani42/nvim-tree.lua",
            config = function() require"nvim-tree".setup {
                update_focused_file = { enable = true }
            } end
        }
        use { 'tami5/lspsaga.nvim', branch = 'nvim51' }
        use "neovim/nvim-lspconfig"
        use "wakatime/vim-wakatime"
        use "nvim-treesitter/nvim-treesitter"
        use "lukas-reineke/format.nvim"
        use "airblade/vim-gitgutter"
        use "b3nj5m1n/kommentary"
        use "p00f/nvim-ts-rainbow"
        use "jiangmiao/auto-pairs"
        use "akinsho/nvim-toggleterm.lua"
        use "f-person/git-blame.nvim"
        use "nvim-lualine/lualine.nvim"
        use "norcalli/nvim-colorizer.lua"
        use "psliwka/vim-smoothie"
        use "Mofiqul/dracula.nvim"
        -- use "romgrk/nvim-treesitter-context"
        -- use "rmagatti/auto-session"
        use "tpope/vim-fugitive"
    end
)
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
map("n", "<leader>bd", "<cmd>bd<CR>") -- wakatime

-- fugitive
map("n", "<leader>ga", ":Git add %:p<CR><CR>")
map("n", "<leader>gc", ":Git commit -v -q<CR>")
map("n", "<leader>gs", ":Git<CR>")
map("n", "<leader>gd", ":Gdiff<CR>")
map("n", "<leader>gm", ":GMove<Space>")
map("n", "<leader>gps", ":Dispatch! git push<CR>")
map("n", "<leader>gpl", ":Dispatch! git pull<CR>")

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
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- file explorer
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")

-- session
--[[ require("auto-session").setup(
    {
        log_level = "info",
        auto_session_enable_last_session = false,
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
    }
)
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"]]
map("n", "<Leader>ss", "<cmd>mksession! .session.vim<cr>")
map("n", "<Leader>sl", "<cmd>source .session.vim<cr>")
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

---------------------- git ---------------------------------
g.gitgutter_grep = "rg"
------------------------------------------------------------------

---------------------- git blame ---------------------------------
g.gitblame_date_format = "%r"
------------------------------------------------------------------

---------------------- terminal ---------------------------------
require "toggleterm".setup {
    size = 10,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_terminals = true,
    start_in_insert = true,
    persist_size = true,
    direction = "float",
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved",
        width = 75,
        height = 17,
        winblend = 3,
        highlights = {border = "Normal", background = "Normal"}
    }
}
--------------------------------------------------------------

---------------------- completions (nvim-cmp) --------------------------
local cmp = require "cmp"

cmp.setup(
    {
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end
        },
        mapping = {
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
            ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ["<C-e>"] = cmp.mapping(
                {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close()
                }
            ),
            ["<CR>"] = cmp.mapping.confirm({select = true})
        },
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "vsnip"}
            },
            {
                {name = "buffer"}
            }
        )
    }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    "/",
    {
        sources = {
            {name = "buffer"}
        }
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":",
    {
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)
--------------------------------------------------------------

---------------------- lsp ---------------------------------
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}

require"lspconfig".pylsp.setup {
    settings = {
        pylsp = {
            configurationSources = {"flake8"},
            plugins = {
                flake8 = {
                    enabled = true,
                    config = "~/dots/python/flake8"
                },
                pycodestyle = {enabled = false},
                pyflakes = {enabled = false},
                pylint = {enabled = false},
                yapf = {enabled = false},
            }
        }
    }
}
require "lspconfig".pyright.setup {
    cmd = {"pyright-langserver", "--stdio"},
    filetypes = {"python"},
    settings = {
        python = {
            disableOrganizeImports = true,
            analysis = {
                typeCheckingMode = "off",
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
            }
        }
    },
    single_file_support = true
}

-- diagnostic signs
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = {
            prefix = " " -- change this to whatever you want your diagnostic icons to be
        }
    }
)

--------------------------------------------------------------

-------------------- snippets -------------------------------
--g.UltiSnipsExpandTrigger = "<tab>"
--g.UltiSnipsJumpForwardTrigger = "<c-b>"
--g.UltiSnipsJumpBackwardTrigger = "<c-z>"
--------------------------------------------------------------

---------------------- lspsaga ---------------------------------
require "lspsaga".init_lsp_saga(
    {
        error_sign = "",
        warn_sign = "",
        hint_sign = " ",
        infor_sign = " "
    }
)
--------------------------------------------------------------

---------------------- autoformat ---------------------------------
require "format".setup {
    ["*"] = {
        {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
    },
    python = {
        {
            cmd = {"darker -i"}
        }
    },
    go = {
        {
            cmd = {"gofmt -w", "goimports -w"},
            tempfile_postfix = ".tmp"
        }
    },
    javascript = {
        {cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}
    },
    markdown = {
        {cmd = {"prettier -w"}}
    },
}

vim.api.nvim_exec([[
augroup Format
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END
]], true)
--------------------------------------------------------------

-------------------- tree-sitter ---------------------------
require "nvim-treesitter.configs".setup {
    ensure_installed = "maintained",
    highlight = {enable = true},
    rainbow = {
        enable = true,
        extended_mode = true -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    }
}
--------------------------------------------------------------

-------------------- bufferline -------------------------------
require "bufferline".setup {
    options = {
        view = "multiwindow",
        diagnostic = "nvim_lsp",
        separator_style = "thin",
        numbers = "ordinal",
        show_buffer_close_icons = false,
        show_close_icon = false,
    }
}
--------------------------------------------------------------

---------------------- colorizer ---------------------------------
require "colorizer".setup()
--------------------------------------------------------------

-------------------- lualine -------------------------------
require "lualine".setup {
    options = {
        icons_enabled = true,
        theme = "dracula-nvim",
        component_separators = "|",
        section_separators = {left = "", right = ""},
        disabled_filetypes = {},
        always_divide_middle = true
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {
            "branch",
            "diff",
            {"diagnostics", sources = {"nvim_lsp", "coc"}}
        },
        lualine_c = {"filename"},
        lualine_x = {"encoding", "fileformat", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
--------------------------------------------------------------
