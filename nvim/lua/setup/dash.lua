-- dashboard setup

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local handle = io.popen("fortune -se computers linux tao wisdom work")
local fortune = handle:read("*a")

local section = dashboard.section
local config = dashboard.config

config.layout = {
	{ type = "padding", val = 5 },
	section.header,
	{ type = "padding", val = 2 },
	section.buttons,
	section.footer,
}

dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("SPC f f", "  Find file", ":Telescope find_files hidden=true no_ignore=true<CR>"),
	dashboard.button("SPC f h", "  Recently opened files", "<cmd>Telescope oldfiles<CR>"),
	dashboard.button("SPC f g", "  Find word", "<cmd>Telescope live_grep<cr>"),
	dashboard.button("SPC f m", "  Jump to bookmarks"),
	dashboard.button("SPC s l", "  Open last session", "<cmd>source .session.vim<CR>"),
}

handle:close()
dashboard.section.footer.val = fortune

alpha.setup(dashboard.config)
