local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.formatting.isort,
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.code_actions.refactoring,
  null_ls.builtins.formatting.cmake_format,
  null_ls.builtins.diagnostics.hadolint,
  null_ls.builtins.diagnostics.ansiblelint,
}

null_ls.setup {
  sources = sources,
}
