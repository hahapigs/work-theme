# For ctrl-t file search
export FFZF_CTRL_T_COMMAND="fd --type f
--exclude .git
--exclude node_modules
--exclude .DS_Store
--exclude '*.pyc'
--exclude '*.class'
"
# Function to toggle hidden files in any fzf context
fzf_toggle_hidden() {
  if [[ -v FZF_HIDDEN ]]; then
    unset FZF_HIDDEN
    echo "Hidden files disabled"
  else
    export FZF_HIDDEN=1
    echo "Hidden files enabled"
  fi
}

# For directory search with alt-c
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
# Custom preview for ctrl-t
export FZF_CTRL_T_OPTS=$FZF_CTRL_T_OPTS"
--header='$(printf "^. to toggle hidden files")'
--prompt '📁 '
"

# Custom preview for ctrl-r
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
--height 80%                  # Use 80% of terminal height
--layout=reverse              # List appears above the prompt (reverse, up, bottom)
--border rounded              # Add rounded borders
--margin=1                    # Set margin to create space around the window
--info=inline                 # Show info inline with results
--multi                       # Enable multi-selection
--cycle                       # Ensure cycling through options
--no-hscroll                  # Disable horizontal scrolling
--preview-window=right:60%:wrap    # Preview pane on right, 60% width, wrapped text (up:3:hidden:wrap)
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
# Preview command explanation:
# - For files: Show with bat (with line numbers) or fall back to cat
# - For directories: Show tree structure
# - For other items: Echo the item
--color='bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4,hl:214,hl+:76'
--color='header:#f38ba8,info:#cba6f7,prompt:#cba6f7,pointer:76,marker:#f5e0dc,gutter:8'
--header='$(printf "^Y 拷贝到剪切板")'
--prompt=' '
--pointer='➤'
--marker='✓'
--bind 'ctrl-a:select-all'                                      # Select all items
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'                # Open in vim
--bind 'ctrl-v:execute(code {+})'                               # Open in VS Code
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'    # Copy to clipboard
--bind 'ctrl-/:toggle-preview'                                  # Change preview window
#--bind '?:change-preview-window(down|hidden|)'
--exit-0
"

