-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

require('conform').formatters.erbformat = {
  inherit = false,
  command = 'erb-formatter',
  args = { '$FILENAME', '--write' },
}

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd 'NERDTreeToggle'
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.tf.jinja' },
  command = 'set filetype=terraform',
})

vim.g.terraform_module_path = '/Users/%s/code/terraform-modules/%s'

local function extract_and_replace_source()
  -- Get the current line number and content from the buffer
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_get_current_line()

  local git_match = line:match 'source%s*=%s*"git@github.com:[^/]+/[^/]+.git//([^?"]+)'

  if git_match then
    local module_path = git_match
    local current_user = vim.loop.os_getenv 'USER'
    local new_path = string.format(vim.g.terraform_module_path, current_user, module_path)

    local new_line = line:gsub('source%s*=%s*".-"', 'source = "' .. new_path .. '"')

    local original_comment = string.format('# original: %s', line)
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, { original_comment })

    vim.api.nvim_set_current_line(new_line)

    print 'Updated source'
  else
    print 'No valid Git URL found on the current line.'
  end
end

local function restore_original_source()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for i, line in ipairs(lines) do
    local original_match = line:match '# original:%s*(.+)'
    if original_match then
      local next_line = lines[i + 1]
      if next_line and next_line:match 'source%s*=%s*"' then
        local start_pos = string.find(next_line, '%S')
        local updated_line = string.rep(' ', start_pos - 1) .. original_match

        vim.api.nvim_buf_set_lines(0, i, i + 1, false, { updated_line })
        vim.api.nvim_buf_set_lines(0, i - 1, i, false, {}) -- remove comment
        print 'Restored original'
        return
      end
    end
  end

  print 'No valid "# original:" comment found.'
end

vim.api.nvim_create_user_command('Tfunpin', extract_and_replace_source, {})
vim.api.nvim_create_user_command('Tfpin', restore_original_source, {})

return {}
