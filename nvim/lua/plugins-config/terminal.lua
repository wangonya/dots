-- terminal setup

local present, term = pcall(require, "toggleterm")
if not present then
	return
end

term.setup({
	shade_terminals = false,
	direction = "float",
	float_opts = {
		border = "curved",
		width = 100,
		height = 30,
		winblend = 0,
	},
	open_mapping = [[<c-\>]],
	start_in_insert = true,
	insert_mappings = true,
})
