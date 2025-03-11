##########################################################
##### junegunn/fzf
##########################################################
# 主目录
FZF_HOME="$HOME/.config/zsh/fzf"
# Default options in a file
export FZF_DEFAULT_OPTS_FILE="$FZF_HOME/.fzfrc"
# Default options
export FZF_DEFAULT_OPTS="--preview '$FZF_HOME/fzf_preview.sh {}'"   # permission denied，execute chmod +x fzf_preview.sh  
# Default command to use when input is tty
export FZF_DEFAULT_COMMAND='fd --type f'

########################
## CTRL + R    
########################
# For command search with ctrl-r
export FZF_CTRL_R_OPTS="
--style full
--border-label ' 命令查找器 '
--header-label ' ctrl+y 复制 '
--prompt='🚀  '
--bind 'focus:+transform-header:echo -n {2..} || $(echo "No command selected")'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'    # Copy to clipboard
--bind '>:preview:awk \"{print \\\$2}\" <<< {} | xargs man 2>/dev/null || echo \"Command error\" | boxes -a c -d tux'
--bind '?:preview:awk \"{print \\\$2}\" <<< {} | xargs timeout 1 tldr 2>/dev/null || echo \"Command error\" | boxes -a c -d cowsay'
"

########################
## CTRL + T    
########################
# For ctrl-t file search
export FZF_CTRL_T_COMMAND="fd --type f --hidden $(cat $FZF_HOME/.fdignore | xargs -I {} echo --exclude '{}')"
# Custom preview for ctrl-t
export FZF_CTRL_T_OPTS="
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
--bind 'enter:execute(echo {+} | xargs -o vim)'                 # Default open in vim
--bind '?:reload(fd --type f)'
--bind '>:reload(fd --type f --hidden \$(cat \$FZF_HOME/.fdignore | xargs -I {} echo --exclude \"{}\"))'
"

########################
## ALT + C / ESC + C    
########################
# For directory search with alt-c
# export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="
--style full
--border-label ' 目录跳转器 '
--header-label ' 绝对路径 '
--prompt '📁  '
--walker-skip .git,node_modules,target
--bind 'focus:+transform-header:echo \$(pwd | awk \"{print \\\$1}\")/{} || $(echo "No directory selected")'
"

########################
## Tab    
########################
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='**'
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'
# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

##########################################################
##### wfxr/forgit
##########################################################
# For forgit global config
export FORGIT_FZF_DEFAULT_OPTS="
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
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept --preview='(fortune | boxes -a c -d cowsay)'
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# tmux tmux >= 3.2
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

