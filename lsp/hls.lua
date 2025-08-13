return {
    cmd = { 'hie-wrapper', '--lsp' },
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    root_markers = { 'stack.yaml', 'package.yaml', '*.cabal', '.git' },
}
