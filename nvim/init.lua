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
        "akinsho/nvim-bufferline.lua",
        requires = "kyazdani42/nvim-web-devicons"
    }
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
    }
    use {"neovim/nvim-lspconfig"}
    use {
	  "hrsh7th/nvim-cmp",
	  requires = {
	    "hrsh7th/vim-vsnip",
	    "hrsh7th/cmp-buffer",
	  }
	}
    use {"wakatime/vim-wakatime"}
    use {"nvim-treesitter/nvim-treesitter"}
    use {"kyazdani42/nvim-tree.lua"}
    use {"glepnir/galaxyline.nvim", branch = "main"}
    use {"lukas-reineke/format.nvim"}
    use {"airblade/vim-gitgutter"}
    use {"b3nj5m1n/kommentary"}
    use {"p00f/nvim-ts-rainbow"}
    use {"jiangmiao/auto-pairs"}
    use {"akinsho/nvim-toggleterm.lua"}
    use {"f-person/git-blame.nvim"}
    use 'glepnir/lspsaga.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'psliwka/vim-smoothie'
    use 'shaunsingh/moonlight.nvim'
    use 'romgrk/nvim-treesitter-context'
    use 'rmagatti/auto-session'
end)
--------------------------------------------------------------

-------------------- colorscheme -------------------------------
g.moonlight_borders = true
require('moonlight').set()
--------------------------------------------------------------

-------------------- key mappings -------------------------------
map("n", "<leader>hl", "<cmd>noh<cr>") -- Clear highlights
map("i", "jk", "<Esc>") -- jk to escape
map("n", "<leader>w", "<cmd>wa<cr>") -- save
map("n", "<leader>q", "<cmd>q<cr>") -- quit
map("n", "<leader>t", "<cmd>WakaTimeToday<CR>") -- wakatime

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
map("n", "<leader>tr", "<cmd>NvimTreeRefresh<cr>")

-- session
map("n", "<Leader>ss", "<cmd>SaveSession<cr>")
map("n", "<Leader>sl", "<cmd>RestoreSession<cr>")
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
g.gitgutter_grep = 'rg'
------------------------------------------------------------------


---------------------- git blame ---------------------------------
g.gitblame_date_format = '%r'
------------------------------------------------------------------

---------------------- session ---------------------------------
-- g.dashboard_default_executive = "telescope"
require('auto-session').setup({
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = nil
})
------------------------------------------------------------------

---------------------- terminal ---------------------------------
require"toggleterm".setup {
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

---------------------- lsp ---------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport =
    {properties = {"documentation", "detail", "additionalTextEdits"}}

--[[ require"lspconfig".pyls.setup {
    settings = {pyls = {plugins = {pylint = {enabled = true}}}}
} ]]
require"lspconfig".pyright.setup {}

-- diagnostic signs
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            prefix = " " -- change this to whatever you want your diagnostic icons to be
        }
    })

--------------------------------------------------------------

-------------------- snippets -------------------------------
--g.UltiSnipsExpandTrigger = "<tab>"
--g.UltiSnipsJumpForwardTrigger = "<c-b>"
--g.UltiSnipsJumpBackwardTrigger = "<c-z>"
--------------------------------------------------------------

---------------------- lspsaga ---------------------------------
require'lspsaga'.init_lsp_saga({
    error_sign = "",
    warn_sign = "",
    hint_sign = " ",
    infor_sign = " "
})
--------------------------------------------------------------

---------------------- autoformat ---------------------------------
require"format".setup {
    ["*"] = {
        {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
    },
    python = {{cmd = {"autopep8 --in-place -a -a -a"}}, {cmd = {"isort"}}},
    lua = {{cmd = {"lua-format -i"}}},
}
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]], true)
--------------------------------------------------------------

---------------------- completions --------------------------

--------------------------------------------------------------

-------------------- tree-sitter ---------------------------
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {enable = true},
    rainbow = {
        enable = true,
        extended_mode = true -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    }
}
--------------------------------------------------------------

-------------------- file explorer ---------------------------
g.nvim_tree_follow = 1
g.nvim_tree_icons = {git = {unstaged = "~"}}
--------------------------------------------------------------

-------------------- bufferline -------------------------------
require"bufferline".setup {
    options = {
        view = "multiwindow",
        diagnostic = "nvim_lsp",
        separator_style = "thin",
        numbers = "ordinal"
    }
}
--------------------------------------------------------------

---------------------- colorizer ---------------------------------
require'colorizer'.setup()
--------------------------------------------------------------

-------------------- statusline -------------------------------
local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local section = gl.section
local vcs = require("galaxyline.provider_vcs")

local colors = {
    bg = "#1B1E2B",
    fg = "#e4f3fa",
    line_bg = "#1B1E2B",
    lbg = "#1B1E2B",
    fg_green = "#2df4c0",
    yellow = "#ffc777",
    cyan = "#b994f1",
    darkblue = "#f1fa8c",
    green = "#2df4c0",
    orange = "#f67f81",
    purple = "#b4a4f4",
    magenta = "#BF616A",
    gray = "#a1abe0",
    blue = "#04d1f9",
    red = "#ff5555"
}

local buffer_not_empty = function()
    if fn.empty(fn.expand("%:t")) ~= 1 then return true end
    return false
end

gl.short_line_list = {"NvimTree", "vista", "dbui", "packer"}

section.left[1] = {
    FirstElement = {
        -- provider = function() return '▊ ' end,
        provider = function() return "  " end,
        highlight = {colors.blue, colors.line_bg}
    }
}
section.left[2] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.magenta,
                i = colors.green,
                v = colors.blue,
                [""] = colors.blue,
                V = colors.blue,
                c = colors.red,
                no = colors.magenta,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.purple,
                Rv = colors.purple,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.red,
                t = colors.red
            }
            cmd("hi GalaxyViMode guifg=" .. mode_color[fn.mode()])
            return "     "
        end,
        highlight = {colors.red, colors.line_bg, "bold"}
    }
}
section.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {
            require("galaxyline.provider_fileinfo").get_file_icon_color,
            colors.line_bg
        }
    }
}
section.left[4] = {
    FileName = {
        -- provider = "FileName",
        provider = function() return fn.expand("%:F") end,
        condition = buffer_not_empty,
        separator = " ",
        separator_highlight = {colors.purple, colors.bg},
        highlight = {colors.purple, colors.line_bg, "bold"}
    }
}

section.right[1] = {
    GitIcon = {
        provider = function() return " " end,
        condition = vcs.check_git_workspace,
        highlight = {colors.orange, colors.line_bg}
    }
}
section.right[5] = {
    GitBranch = {
        provider = "GitBranch",
        condition = vcs.check_git_workspace,
        separator = "",
        separator_highlight = {colors.purple, colors.bg},
        highlight = {colors.orange, colors.line_bg, "bold"}
    }
}

local checkwidth = function()
    local squeeze_width = fn.winwidth(0) / 2
    if squeeze_width > 40 then return true end
    return false
end

section.right[2] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "+",
        highlight = {colors.green, colors.line_bg}
    }
}
section.right[3] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = "~",
        highlight = {colors.yellow, colors.line_bg}
    }
}
section.right[4] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = "-",
        highlight = {colors.red, colors.line_bg}
    }
}

section.right[6] = {
    LineInfo = {
        provider = "LineColumn",
        separator = " ",
        separator_highlight = {colors.blue, colors.line_bg},
        highlight = {colors.gray, colors.line_bg}
    }
}

section.right[8] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        separator = " ",
        icon = " ",
        highlight = {colors.red, colors.line_bg},
        separator_highlight = {colors.bg, colors.bg}
    }
}
section.right[9] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        -- separator = " ",
        icon = " ",
        highlight = {colors.yellow, colors.line_bg},
        separator_highlight = {colors.bg, colors.bg}
    }
}

section.right[10] = {
    DiagnosticInfo = {
        -- separator = " ",
        provider = "DiagnosticInfo",
        icon = " ",
        highlight = {colors.green, colors.line_bg},
        separator_highlight = {colors.bg, colors.bg}
    }
}

section.right[11] = {
    DiagnosticHint = {
        provider = "DiagnosticHint",
        -- separator = " ",
        icon = " ",
        highlight = {colors.blue, colors.line_bg},
        separator_highlight = {colors.bg, colors.bg}
    }
}

section.short_line_left[1] = {
    BufferType = {
        provider = "FileIcon",
        separator = " ",
        separator_highlight = {"NONE", colors.lbg},
        highlight = {colors.blue, colors.lbg, "bold"}
    }
}

section.short_line_left[2] = {
    SFileName = {
        provider = function()
            local fileinfo = require("galaxyline.provider_fileinfo")
            local fname = fileinfo.get_current_file_name()
            for _, v in ipairs(gl.short_line_list) do
                if v == vim.bo.filetype then return "" end
            end
            return fname
        end,
        condition = buffer_not_empty,
        highlight = {colors.white, colors.lbg, "bold"}
    }
}

section.short_line_right[1] = {
    BufferIcon = {provider = "BufferIcon", highlight = {colors.fg, colors.lbg}}
}
--------------------------------------------------------------

