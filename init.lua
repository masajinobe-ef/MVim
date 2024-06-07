-- reduce Neovim startup time with plugins
if vim.loader then
	vim.loader.enable()
end


-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
