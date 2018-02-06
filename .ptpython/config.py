from __future__ import unicode_literals
from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.key_binding.input_processor import KeyPress
from prompt_toolkit.keys import Keys
from pygments.token import Token

from ptpython.layout import CompletionVisualisation

# For autoreplacement
CORRECTIONS = {
    'impotr': 'import',
    'ipmort': 'import',
    'pritn': 'print',
    'frmo': 'from',
}


def configure(repl):
    repl.vi_mode = True

    repl.enable_input_validation = True

    # Enable open-in-editor. Pressing C-X C-E in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Use this colorscheme for the code.
    repl.use_code_colorscheme('manni')

    # Typing ControlE twice should also execute the current command.
    # (Alternative for Meta-Enter.)
    @repl.add_key_binding(Keys.ControlE, Keys.ControlE)
    def _(event):
        b = event.current_buffer
        if b.accept_action.is_returnable:
            b.accept_action.validate_and_handle(event.cli, b)

    # Rebind vim exit insert mode.
    @repl.add_key_binding('j', 'k', filter=ViInsertMode())
    def _(event):
        " Map 'jk' to Escape. "
        event.cli.input_processor.feed(KeyPress(Keys.Escape))

    @repl.add_key_binding(' ')
    def _(event):
        ' When a space is pressed. Check & correct word before cursor. '
        b = event.cli.current_buffer
        w = b.document.get_word_before_cursor()
        if w is not None:
            if w in CORRECTIONS:
                b.delete_before_cursor(count=len(w))
                b.insert_text(CORRECTIONS[w])
        b.insert_text(' ')
