---@type vim.lsp.Config
return {
    cmd = { 'vacuum', 'language-server' },
    filetypes = { 'yaml.openapi', 'json.openapi' },
    root_markers = { '.git' },
}
