vim.filetype.add({
    pattern = {
        ['openapi.ya?ml'] = 'yaml.openapi',
        ['openapi.json'] = 'json.openapi',
        ['.*/schemas/.*%.ya?ml'] = 'yaml.openapi',
        ['.*/schemas/.*%.json'] = 'json.openapi',
    },
})
