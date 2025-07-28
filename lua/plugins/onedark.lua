return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "deep", -- other options: "dark", "cool", "warm", "warmer"
		})
		require("onedark").load()
	end,
}
