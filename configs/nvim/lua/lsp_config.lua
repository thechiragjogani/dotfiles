vim.cmd [[ packadd coq ]]
local lsp = require('lspconfig')
local coq = require "coq"
lsp.<server>.setup(coq.lsp_ensure_capabilities(<stuff...>))