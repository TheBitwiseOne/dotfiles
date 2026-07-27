return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		filesystem = {
			window = {
				position = "right", -- Move NeoTree to the right
			},
			filtered_items = {
				visible = true,
				hide_dotfiles = true,
				hide_gitignored = true,
			},
		},
		buffers = {
			window = {
				position = "right", -- Buffers view to the right
			},
		},
		git_status = {
			window = {
				position = "right", -- Git status view to the right
			},
		},
	},
}
