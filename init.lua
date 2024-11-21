require("surajpatel.core")
require("surajpatel.lazy")
-- Enable line wrapping
vim.opt.wrap = true

-- Plugin manager setup (for example, lazy.nvim)
require("lazy").setup({
	"folke/tokyonight.nvim", -- Add tokyonight as a plugin
	"kyazdani42/nvim-tree.lua", -- Add nvim-tree plugin
	"nvim-telescope/telescope.nvim", -- Add telescope plugin
	-- other plugins...
})

-- Set up the tokyonight colorscheme
require("tokyonight").setup({
	transparent = true, -- Enable transparency
})

-- Apply the colorscheme
vim.cmd("colorscheme tokyonight")

-- Make nvim-tree transparent
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })

-- Make telescope transparent
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })

-- Make status line and winbar transparent
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
vim.api.nvim_set_hl(0, "Winbar", { bg = "none" })
vim.api.nvim_set_hl(0, "WinbarNC", { bg = "none" })

local diagnostic_active = true

-- Function to toggle diagnostics on or off
local function toggle_diagnostics(enable)
	diagnostic_active = enable
	if enable then
		vim.diagnostic.enable()
	else
		vim.diagnostic.disable() -- Corrected from enable(false) to disable()
	end
end

-- Autocmd group for managing diagnostics based on mode
local diagnostic_augroup = vim.api.nvim_create_augroup("diagnostic_toggle", { clear = true })

-- Disable diagnostics when entering visual mode
vim.api.nvim_create_autocmd("ModeChanged", {
	group = diagnostic_augroup,
	pattern = "*:[vV]*", -- Entering visual mode
	callback = function()
		toggle_diagnostics(false)
	end,
})

-- Enable diagnostics when leaving visual mode and entering normal mode
vim.api.nvim_create_autocmd("ModeChanged", {
	group = diagnostic_augroup,
	pattern = "[vV]*:*", -- Leaving visual mode
	callback = function()
		toggle_diagnostics(true)
	end,
})

-- Move current line up with Alt + UpArrow
vim.api.nvim_set_keymap("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
-- Move current line down with Alt + DownArrow
vim.api.nvim_set_keymap("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
