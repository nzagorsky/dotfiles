" Mappings
let g:jedi#documentation_command = 'K'
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_command = "<leader>d"
let g:jedi#rename_command = "<leader>r"
let g:jedi#usages_command = '<Leader>n'
let g:jedi#auto_close_doc = 1 " Unite/ref and pydoc are more useful.
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 1
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.

" Syntax
let python_highlight_all=1

"" Jedi Vim settings.
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#show_docstring = 1


"" Hack for working with venvs.
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
        project_base_dir = os.environ['VIRTUAL_ENV']
        activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
        execfile(activate_this, dict(__file__=activate_this))
EOF
