# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
#
# TIPS:
#   1) Use `read -k` to get a key sequence.
#   2) Use `bindkey` to output all the key bindings for the global keymap.

typeset -gA keys=(
  Escape          '^['

  Ctrl+R          '^R'
  Ctrl+Y          '^Y'
  Up              '^[[A'
  Down            '^[[B'
)

# Erase whole line
bindkey -- "${keys[Ctrl+R]}" fzf-history-widget
bindkey -- "${keys[Ctrl+Y]}" mcfly-history-widget

# autoload -U history-substring-search-up
# autoload -U history-substring-search-down
# zle -N history-substring-search-up
# zle -N history-substring-search-down
bindkey -- "${keys[Up]}" history-substring-search-up
bindkey -- "${keys[Down]}" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Insert "sudo" at the beginning of line with Esc+Esc key
zle -N sudo-command-line
sudo-command-line() {
  if [[ $BUFFER == sudo\ * ]]; then
    LBUFFER="${LBUFFER#sudo }"
  else
    LBUFFER="sudo $LBUFFER"
  fi
}
bindkey "${keys[Escape]}${keys[Escape]}" sudo-command-line
