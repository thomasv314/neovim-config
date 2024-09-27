-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

require('conform').formatters.erbformat = {
  inherit = false,
  command = 'erb-formatter',
  args = { '$FILENAME', '--write' },
}

return {}
