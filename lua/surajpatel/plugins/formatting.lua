-- lua/suraj/plugins/lsp/formatting.lua

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },

				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				java = { "google-java-format" },
				cpp = { "clang-format" }, -- Fixed typo here
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000, -- Increased timeout to 2000 ms
			},
		})

		-- Key mapping for manual formatting
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000, -- Increased timeout to match the save setting
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
