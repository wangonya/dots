local colors = {
	base00 = "#000000",
	base01 = "#121212",
	base02 = "#222222",
	base03 = "#333333",
	base04 = "#999999",
	base05 = "#c1c1c1",
	base06 = "#999999",
	base07 = "#c1c1c1",
	base08 = "#5f8787",
	base09 = "#aaaaaa",
	base0A = "#556677",
	base0B = "#7799bb",
	base0C = "#aaaaaa",
	base0D = "#888888",
	base0E = "#999999",
	base0F = "#444444",
}

local function hi(group, fg, bg, bold, underline)
	local highlight_string = "hi " .. group

	if fg then
		highlight_string = highlight_string .. " guifg=" .. fg
	end

	if bg then
		highlight_string = highlight_string .. " guibg=" .. bg
	end

	if bold then
		highlight_string = highlight_string .. " cterm=bold"
	end

	if underline then
		highlight_string = highlight_string .. " cterm=underline"
	end

	vim.cmd(highlight_string)
end

-- Editor colors
hi("Normal", colors.base05, colors.base00)
hi("Bold", nil, nil, true)
hi("Debug", colors.base08)
hi("Directory", colors.base0D)
hi("Error", colors.base00, colors.base08)
hi("ErrorMsg", colors.base08, colors.base00)
hi("Exception", colors.base08)
hi("FoldColumn", colors.base0C, colors.base01)
hi("Folded", colors.base03, colors.base01)
hi("IncSearch", colors.base01, colors.base09)
hi("Macro", colors.base08)
hi("MatchParen", nil, colors.base03)
hi("ModeMsg", colors.base0B)
hi("MoreMsg", colors.base0B)
hi("Question", colors.base0D)
hi("Search", colors.base03, colors.base0A)
hi("Substitute", colors.base03, colors.base0A)
hi("SpecialKey", colors.base03)
hi("TooLong", colors.base08)
hi("Underlined", colors.base08, nil, nil, true)
hi("Visual", nil, colors.base02)
hi("VisualNOS", colors.base08)
hi("WarningMsg", colors.base08)
hi("WildMenu", colors.base08, colors.base0A)
hi("Title", colors.base0D)
hi("Conceal", colors.base0D, colors.base00)
hi("Cursor", colors.base00, colors.base05)
hi("NonText", colors.base03)
hi("LineNr", colors.base03, colors.base00)
hi("SignColumn", colors.base03, colors.base00)
hi("StatusLine", colors.base01, colors.base04)
hi("StatusLineNC", colors.base03, colors.base01)
hi("VertSplit", colors.base02, colors.base00)
hi("ColorColumn", nil, colors.base01)
hi("CursorColumn", nil, colors.base01)
hi("CursorLine", nil, colors.base01)
hi("CursorLineNr", colors.base04, colors.base01)
hi("QuickFixLine", nil, colors.base01)
hi("PMenu", colors.base05, colors.base00)
hi("PMenuSel", colors.base01, colors.base05)
hi("TabLine", colors.base03, colors.base01)
hi("TabLineFill", colors.base03, colors.base01)
hi("TabLineSel", colors.base0B, colors.base01)

-- Standard syntax highlighting
hi("Boolean", colors.base09)
hi("Character", colors.base08)
hi("Comment", colors.base03)
hi("Conditional", colors.base0E)
hi("Constant", colors.base09)
hi("Define", colors.base0E, nil)
hi("Delimiter", colors.base0F)
hi("Float", colors.base09)
hi("Function", colors.base0D)
hi("Identifier", colors.base08, nil)
hi("Include", colors.base0D)
hi("Keyword", colors.base0E)
hi("Label", colors.base0A)
hi("Number", colors.base09)
hi("Operator", colors.base05, nil)
hi("PreProc", colors.base0A)
hi("Repeat", colors.base0A)
hi("Special", colors.base0C)
hi("SpecialChar", colors.base0F)
hi("Statement", colors.base08)
hi("StorageClass", colors.base0A)
hi("String", colors.base0B)
hi("Structure", colors.base0E)
hi("Tag", colors.base0A)
hi("Todo", colors.base0A, colors.base01)
hi("Type", colors.base0A)
hi("Typedef", colors.base0A)

-- Plugins

-- GitSigns
hi("GitSignsAdd", colors.base0B, colors.base00)
hi("GitSignsChange", colors.base0D, colors.base00)
hi("GitSignsDelete", colors.base08, colors.base00)
hi("GitSignsChangeDelete", colors.base0E, colors.base00)

-- Indent-blankline
hi("IndentBlanklineChar", colors.base01, colors.base00)
hi("IndentBlanklineContextChar", colors.base02, colors.base00)
hi("IndentBlanklineContextStart", nil, nil, true)
