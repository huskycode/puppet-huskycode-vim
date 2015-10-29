#
# Sets defaults for vimrc that not everyone might want
#
class vim::default {

  vim::rc { 'highlight comment ctermfg=darkgray': }
  vim::rc { ':set bg=dark': }
}
