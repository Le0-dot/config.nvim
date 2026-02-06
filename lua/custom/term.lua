-- Common application shortcuts
vim.keymap.set(
    { 'n', 'i', 't' }, '<M-t>', function() vim.cmd([[$tab term]]) end, { desc = 'Open new terminal tab with shell' }
)

vim.keymap.set(
    { 'n', 'i', 't' }, '<M-g>', function()
        vim.cmd([[$tab term lazygit]])

        -- Try closing when entering another tab
        vim.api.nvim_create_autocmd('TabEnter', {
            callback = function() pcall(vim.cmd.tabclose, '#') end,
            once = true,
        })

        -- Works for some reason
        vim.o.cmdheight = 0
    end,
    { desc = 'Open new terminal tab with lazygit' }
)

vim.keymap.set(
    { 'n', 'i', 't' }, '<M-o>', function()
        vim.cmd([[$tab term opencode]])
        -- Works for some reason
        vim.o.cmdheight = 0
    end,
    { desc = 'Open new terminal tab with opencode' }
)

-- Bind Alt + n to switch tabs
for i = 1, 9 do
    vim.keymap.set(
        { 'n', 'i', 't' }, '<M-' .. i .. '>', function() pcall(vim.cmd.tabnext, i) end,
        { desc = 'Open ' .. i .. ' tab' }
    )
end

-- Make Ctrl + [ and Esc work in term window
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*sh',
    callback = function(args)
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = args.buf })
        vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { buffer = args.buf })
    end
})

-- Remove statusline in terminal windows
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
    pattern = 'term://*',
    callback = function() vim.opt.laststatus = 0 end
})

-- Restore statusline on leaving terminal windows
vim.api.nvim_create_autocmd('BufLeave', {
    pattern = 'term://*',
    callback = function() vim.opt.laststatus = 2 end
})

-- Enter TERMINAL mode on entering term window
vim.api.nvim_create_autocmd('TabLeave', {
    callback = function()
        vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter', 'SafeState' }, {
            pattern = 'term://*',
            command = 'startinsert',
            once = true,
        })
    end
})

-- Skip the exit code
vim.api.nvim_create_autocmd('TermClose', {
    pattern = 'term://*',
    callback = function(_) vim.api.nvim_input('<CR>') end
})






-- Events = {
--     'BufAdd',
--     'BufDelete',
--     'BufEnter',
--     'BufFilePost',
--     'BufFilePre',
--     'BufHidden',
--     'BufLeave',
--     'BufModifiedSet',
--     'BufNew',
--     'BufNewFile',
--     'BufRead',
--     'BufReadPost',
--     'BufReadCmd',
--     'BufReadPre',
--     'BufUnload',
--     'BufWinEnter',
--     'BufWinLeave',
--     'BufWipeout',
--     'BufWrite',
--     'BufWritePre',
--     'BufWriteCmd',
--     'BufWritePost',
--     'ChanInfo',
--     'ChanOpen',
--     'CmdUndefined',
--     'CmdlineChanged',
--     'CmdlineEnter',
--     'CmdlineLeave',
--     'CmdwinEnter',
--     'CmdwinLeave',
--     'ColorScheme',
--     'ColorSchemePre',
--     'CompleteChanged',
--     'CompleteDonePre',
--     'CompleteDone',
--     'CursorHold',
--     'CursorHoldI',
--     'CursorMoved',
--     'CursorMovedC',
--     'CursorMovedI',
--     'DiffUpdated',
--     'DirChanged',
--     'DirChangedPre',
--     'ExitPre',
--     'FileAppendCmd',
--     'FileAppendPost',
--     'FileAppendPre',
--     'FileChangedRO',
--     'FileChangedShell',
--     'FileChangedShellPost',
--     'FileReadCmd',
--     'FileReadPost',
--     'FileReadPre',
--     'FileType',
--     'FileWriteCmd',
--     'FileWritePost',
--     'FileWritePre',
--     'FilterReadPost',
--     'FilterReadPre',
--     'FilterWritePost',
--     'FilterWritePre',
--     'FocusGained',
--     'FocusLost',
--     'FuncUndefined',
--     'UIEnter',
--     'UILeave',
--     'InsertChange',
--     'InsertCharPre',
--     'InsertEnter',
--     'InsertLeavePre',
--     'InsertLeave',
--     'MenuPopup',
--     'ModeChanged',
--     'OptionSet',
--     'QuickFixCmdPre',
--     'QuickFixCmdPost',
--     'QuitPre',
--     'RemoteReply',
--     'SearchWrapped',
--     'RecordingEnter',
--     'RecordingLeave',
--     'SafeState',
--     'SessionLoadPost',
--     'SessionWritePost',
--     'ShellCmdPost',
--     'Signal',
--     'ShellFilterPost',
--     'SourcePre',
--     'SourcePost',
--     'SourceCmd',
--     'SpellFileMissing',
--     'StdinReadPost',
--     'StdinReadPre',
--     'SwapExists',
--     'Syntax',
--     'TabEnter',
--     'TabLeave',
--     'TabNew',
--     'TabNewEntered',
--     'TabClosed',
--     'TermOpen',
--     'TermEnter',
--     'TermLeave',
--     'TermClose',
--     'TermRequest',
--     'TermResponse',
--     'TextChanged',
--     'TextChangedI',
--     'TextChangedP',
--     'TextChangedT',
--     'TextYankPost',
--     'User',
--     'VimEnter',
--     'VimLeavePre',
--     'VimResume',
--     'VimSuspend',
--     'WinClosed',
--     'WinEnter',
--     'WinLeave',
--     'WinNew',
--     'WinScrolled',
--     'WinResized',
-- }
--
--
-- vim.api.nvim_create_autocmd(Events, {
--     callback = function(args)
--         print(args.buf .. ' ' .. args.event .. ' ' .. args.file .. '\n')
--     end
-- })
