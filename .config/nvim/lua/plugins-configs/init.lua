local nvim_tree_conf_ok, _ = pcall(require, "plugins-configs.nvim-tree")
if not nvim_tree_conf_ok then
	vim.notify("There was a problem while requiring nvim-tree configs")
end

local treesitter_conf_ok, _ = pcall(require, "plugins-configs.treesitter")
if not treesitter_conf_ok then
	vim.notify("There was a problem while requiring treesitter configs")
end

local autopairs_conf_ok, _ = pcall(require, "plugins-configs.autopairs")
if not autopairs_conf_ok then
	vim.notify("There was a problem while requiring autopairs configs")
end

local comment_conf_ok, _ = pcall(require, "plugins-configs.comment")
if not comment_conf_ok then
	vim.notify("There was a problem while requiring comment configs")
end

local bufferline_conf_ok, _ = pcall(require, "plugins-configs.bufferline")
if not bufferline_conf_ok then
	vim.notify("There was a problem while requiring bufferline configs")
end

local telescope_conf_ok, _ = pcall(require, "plugins-configs.telescope")
if not telescope_conf_ok then
	vim.notify("There was a problem while requiring telescope configs")
end
