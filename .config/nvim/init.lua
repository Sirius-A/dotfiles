-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- leader.
vim.g.mapleader = " "

-- Attempt to run impatient, but it may not have been installed yet
pcall(require, "impatient")

