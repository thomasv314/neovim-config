-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

require('conform').formatters.erbformat = {
  inherit = false,
  command = 'erb-formatter',
  args = { '$FILENAME', '--write' },
}

vim.api.nvim_set_hl(0, 'TrailingWhitespace', { bg = 'LightRed' })
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  command = [[
		syntax clear TrailingWhitespace |
		syntax match TrailingWhitespace "\_s\+$"
	]],
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  callback = function(ev)
    save_cursor = vim.fn.getpos '.'
    vim.cmd [[%s/\s\+$//e]]
    vim.fn.setpos('.', save_cursor)
  end,
})

-- reload when changed
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd 'checktime'
    end
  end,
  desc = 'Auto reload file when changed externally',
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  callback = function()
    if vim.fn.getbufvar(vim.fn.bufnr(), '&modified') == 0 then
      vim.cmd 'silent! checktime'
    end
  end,
  desc = 'Auto reload file when changed externally',
})

return {}
