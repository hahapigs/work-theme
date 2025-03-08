##########################################################
##### junegunn/fzf
##########################################################
# For fzf global config
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
--border --padding 1,2
--input-label ' Input '
--height 80%                  # Use 80% of terminal height
--layout reverse              # List appears above the prompt (reverse, up, bottom)
--border rounded              # Add rounded borders
--margin 1                    # Set margin to create space around the window
--info inline                 # Show info inline with results
--multi                       # Enable multi-selection
--no-hscroll                  # Disable horizontal scrolling
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (exa --tree --level=2 --icons {} || lsd --tree --depth=2 {} || tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color 'bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4,hl:214,hl+:76'
--color 'border:#aaaaaa,label:#cccccc,gutter:8'
--color 'preview-border:#9999cc,preview-label:#ccccff'
--color 'input-border:#996666,input-label:#ffcccc,prompt:#cba6f7'
--color 'header:#f38ba8,header-border:#6699cc,header-label:#99ccff'
--color 'list-border:#669966,list-label:#99cc99'
--color 'pointer:76,marker:226'
--pointer='➤ '
--bind 'result:transform-list-label:[[ -z \$FZF_QUERY ]] && echo \" \$FZF_MATCH_COUNT items \" || echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"'
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-t:top'
--bind 'ctrl-j:down'
--bind 'ctrl-k:up'
--exit-0
"

# For ctrl-t file search
export FZF_CTRL_T_COMMAND="fd --type f
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

# For command search with ctrl-r
export FZF_CTRL_R_OPTS=$FZF_CTRL_R_OPTS"
--style full
--border-label ' 命令查找器 '
--header-label ' ctrl+y 复制 '
--prompt='🚀  '
--bind 'focus:+transform-header:echo -n {2..} || $(echo "No command selected")'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'    # Copy to clipboard
--bind '>:preview:man \$(echo -n {2..} | awk \"{print \\\$1}\") 2>/dev/null || (echo \"Command error\" | boxes -a c -d tux)'
--bind '?:preview:timeout 1 tldr \$(echo -n {2..} | awk \"{print \\\$1}\") 2>/dev/null || (echo \"Command error\" | boxes -a c -d cowsay)'
"

# Custom preview for ctrl-t
export FZF_CTRL_T_OPTS=$FZF_CTRL_T_OPTS"
--style full
--border-label ' 文件查找器 '
--header-label ' 文件类型 '
--prompt '🔍  '
--marker='✓ '
--bind 'focus:+transform-header:file --brief {} || $(echo "No file selected")'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'    # Copy to clipboard
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'                # Open in vim
--bind 'ctrl-v:execute(code {+})'                               # Open in VS Code
--bind 'ctrl-a:select-all'                                      # Select all items
"

# For directory search with alt-c
# export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS=$FZF_ALT_C_COMMAND"
--style full
--border-label ' 目录跳转器 '
--header-label '  '
--prompt '📁  '
--bind 'focus:+transform-header:file --brief {} || $(echo "No file selected")'
"

##########################################################
##### wfxr/forgit  
##########################################################
# For forgit global config
export FORGIT_FZF_DEFAULT_OPTS="$FORGIT_FZF_DEFAULT_OPTS
--style full
--border-label ' forgit '
--header-label ' branch '
--prompt '🛠️  '
--marker='✓ '
--bind 'focus:+transform-header:git branch --show-current || $(echo "No git")'
"

##########################################################
##### Aloxaf/fzf-tab 
##########################################################
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# tmux tmux >= 3.2
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

