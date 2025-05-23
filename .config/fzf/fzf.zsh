##########################################################
##### junegunn/fzf
##########################################################
# 主目录
export FZF_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/fzf"
# Default options in a file
export FZF_DEFAULT_OPTS_FILE="${FZF_HOME}/.fzfrc"
# Default options
export FZF_DEFAULT_OPTS="--preview '${FZF_HOME}/fzf_preview.sh {}'"   # permission denied，execute chmod +x fzf_preview.sh
# Default command to use when input is tty
export FZF_DEFAULT_IGNORE="$(${FZF_HOME}/fzf_ignore.sh fd)"
export FZF_DEFAULT_COMMAND="echo $FZF_DEFAULT_IGNORE | xargs fd --hidden --color always"

########################
## CTRL + R
########################
# For command search with ctrl-r
export FZF_CTRL_R_OPTS="
--border-label ' 🚀 Commands '
--header-label ' CTRL-T Copy to clipboard '
--prompt=' '
--bind 'focus:+transform-header:echo -n {2..} || $(echo "No command selected")'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'    # Copy to clipboard
--bind '>:preview:awk \"{print \\\$2}\" <<< {} | xargs man 2>/dev/null || echo \"Command error\" | boxes -a c -d tux'
--bind '?:preview:awk \"{print \\\$2}\" <<< {} | xargs timeout 1 tldr 2>/dev/null || echo \"Command error\" | boxes -a c -d cowsay'
"

########################
## CTRL + T
########################
# For ctrl-t file search
export FZF_CTRL_T_COMMAND="echo $FZF_DEFAULT_IGNORE | xargs fd --type f --hidden --color always";
# Custom preview for ctrl-t
export FZF_CTRL_T_OPTS="
--border-label ' 🔍 Files '
--header-label ' File Type '
--prompt '> '
--marker='✓ '
--bind 'focus:+transform-header:file --brief {} || $(echo "No file selected")'
--bind 'ctrl-y:execute-silent(echo -n {} | pbcopy)+abort'       # Copy to clipboard
--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'               # Open in nvim
--bind 'ctrl-v:execute(code {+})'                               # Open in VS Code
--bind 'ctrl-a:select-all'                                      # Select all items
--bind 'enter:execute(echo {+} | xargs -o nvim)'                # Default open in nvim
--bind '?:reload(echo \$(\${FZF_HOME}/fzf_ignore.sh fd) | xargs fd --type f --color always)'
--bind '>:reload(eval \${FZF_CTRL_T_COMMAND})'
"

########################
## ALT + C / ESC + C
########################
# For directory search with alt-c
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow $FZF_DEFAULT_IGNORE --color always";
export FZF_ALT_C_OPTS="
--border-label ' 📁 Directory '
--header-label ' Absolute Path '
--prompt '> '
--bind 'focus:+transform-header:echo \$(pwd | awk \"{print \\\$1}\")/{} || $(echo "No directory selected")'
"

########################
## Fuzzy completion for Tab
########################
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='**'
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info inline-right:"< "'
# Options for path completion (e.g. vim **<TAB>)  file,dir,follow,hidden
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
# Options for directory completion (e.g. cd **<TAB>) dir,follow
export FZF_COMPLETION_DIR_OPTS='--walker file,follow'
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview '${FZF_HOME}/fzf_preview.sh {}'     "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"                  "$@" ;;
    ssh)          fzf --preview 'dig {}'                            "$@" ;;
    *)            fzf --preview '${FZF_HOME}/fzf_preview.sh {}'     "$@" ;;
  esac
}

### Customizing completion source for paths and directories
# Use fd (https://github.com/sharkdp/fd) for listing path candidates
# e.g. vim ~/**<tab> runs with the prefix () as the first argument fzf_compgen_path() ~/
_fzf_compgen_path() {
  # fd --hidden --follow $(eval echo $FZF_DEFAULT_IGNORE) --color always . "$1"
  echo $FZF_DEFAULT_IGNORE | xargs fd --hidden --follow --color always . "$1"
}

# Use fd to generate the list for directory completion
# e.g. cd foo**<tab> runs with the prefix () as the first argument fzf_compgen_dir() foo
_fzf_compgen_dir() {
  # fd --type d --hidden --follow $(eval echo $FZF_DEFAULT_IGNORE) --color always . "$1"
  echo $FZF_DEFAULT_IGNORE | xargs fd --type d --hidden --follow --color always . "$1"
}

##########################################################
##### wfxr/forgit
##########################################################
# For forgit global config
export FORGIT_FZF_DEFAULT_OPTS="
--style full
--border-label ' 🏖️  forgit '
--header-label ' branch '
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
zstyle ':fzf-tab:complete:cd:*' fzf-preview '${FZF_HOME}/fzf_preview.sh $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept --preview-window right:50%
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# tmux tmux >= 3.2
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

##########################################################
##### Custom function
##########################################################

########################
## autojump / zoxide
########################
# NOTE: 如果安装了amazon-q，同时保留两者，请务必保证和 j 不同名，否则fzf preview在前两者之后弹出，影响体验。
# 确保此函数在source autojump.sh 之后加载，否则fzf preview不会生效
# amazon-q界面更友好，fzf更贴合terminal，前者支持模糊检索，后者自动补全效率更高
jr() {
  local dir
  if (( $+commands[zoxide] )); then
    dir=$(zoxide query -l | fzf --height 40%) && cd "$dir"
  elif (( $+commands[autojump] )); then
    dir=$(autojump -s | sort -nr | awk '{print $2}' | fzf --height 40%) && cd "$dir"
  fi
}

########################
## ps
########################
# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
  local pid
  if [ "$UID" != "0" ]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

########################
## Homebrew
########################
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackage
bip() {
  local inst=$(brew search "$@" | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]ackage
bup() {
  local upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]ackage (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

# Install or open the webpage for the selected application 
# using brew cask search as input source
# and display a info quickview window for the currently marked application 
bicp() {
    local token
    token=$(brew search --casks "$1" | fzf --preview 'brew info {}')
                    
    if [ "x$token" != "x" ]                                                                
    then             
        echo "(I)nstall or open the (h)omepage of $token"
        read input                             
        if [ $input = "i" ] || [ $input = "I" ]; then    
            brew install --cask $token                   
        fi                                                                                    
        if [ $input = "h" ] || [ $input = "H" ]; then                                         
            brew home $token                     
        fi                                           
    fi                             
}

# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
bccp() {
    local token
    token=$(brew list --casks | fzf --preview 'brew info {}')

    if [ "x$token" != "x" ]
    then
        echo "(U)ninstall or open the (h)omepae of $token"
        read input
        if [ $input = "u" ] || [ $input = "U" ]; then
            brew uninstall --cask $token
        fi
        if [ $input = "h" ] || [ $token = "h" ]; then
            brew home $token
        fi
    fi
}
