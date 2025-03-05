##########################################################
##### Install `zinit` and load it                                                 
##########################################################
## Automatic
# [[ ! -d "${HOME}/.local/share/zinit" ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

## Manual
# ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# [[ ! -d $ZINIT_HOME ]] &&
#     print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f" &&
#     command mkdir -p "$(dirname $ZINIT_HOME)"
# [[ ! -d $ZINIT_HOME/.git ]] &&
#     command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
#         print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
#         print -P "%F{160}▓▒░ The clone has failed.%F"
#
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit

## MacOS (Homebrew)
# [[ ! command -v zinit ]] && brew install zinit
[[ ! -d $(brew --prefix zinit) ]] && brew install zinit 

# Load zinit
source /usr/local/opt/zinit/zinit.zsh

##########################################################
##### Load Oh My Zsh's libraries                                                  
##########################################################
# zinit snippet https://github.com/ohmyzsh/ohmyzsh/tree/master/lib/git.zsh
# zinit snippet OMZ::lib/git.zsh
zinit snippet OMZL::git.zsh                 # git 命令别名
zinit snippet OMZL::cli.zsh                 # omz 命令
zinit snippet OMZL::history.zsh             # 命令行历史
zinit snippet OMZL::clipboard.zsh           # 剪切板，不加载此类库会导致 copypath 等命令无效
zinit snippet OMZL::completion.zsh          # 自动补全
zinit snippet OMZL::key-bindings.ZSH        # 快捷键绑定
zinit snippet OMZL::directories.zsh         # 目录导航和管理，例如：cd ...

##########################################################
##### Load Oh My Zsh's plugins                                                  
##########################################################
# zinit snippet OMZP::git/git.plugin.zsh
zinit ice wait"1" lucid
zinit snippet OMZP::git

# Lazy-load z
# zinit ice wait"1" lucid
# zinit snippet OMZP::z

# Lazy-load sudo
zinit ice wait"1" lucid
zinit snippet OMZP::sudo

# Lazy-load copypath
zinit ice wait"1" lucid
zinit snippet OMZP::copypath

# Lazy-load copybuffer, ctrl+o 快速复制当前行命令, WarpTerminal 不支持copybuffer，但是可以通过shift+up/down实现快速选中或取消选中
if [[ -n $TMUX ]] || [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  zinit ice wait"1" lucid
  zinit snippet OMZP::copybuffer
fi

# Lazy-load command-not-found
# zinit ice wait"1" lucid
# zinit snippet OMZP::command-not-found

# Lazy-load dash
zinit ice wait"1" lucid
zinit snippet OMZP::dash

##########################################################
##### Load external plugins of Oh My Zsh                                                 
##########################################################
# Lazy-load zsh-defer
# zinit ice wait"1" lucid
# zinit light romkatv/zsh-defer

# Lazy-load fzf-tab
zinit ice wait"0a" lucid
zinit light Aloxaf/fzf-tab

# Lazy-load zsh-autosuggestions with priority loading
# Changed wait to "0a" to load before syntax highlighting
# 没有 atload='_zsh_autosuggest_start' 会影响首个 prompt 失去提示功能
zinit ice wait"0b" lucid atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Lazy-load syntax highlighting AFTER autosuggestions
# Changed wait to "0b" to ensure proper order
zinit ice wait"0c" lucid atinit"FAST_HIGHLIGHT=();zpcompinit;zpcdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting       # zsh-users/zsh-syntax-highlighting 更新滞后

# Lazy-load zsh-completions
zinit ice wait"0b" lucid blockf
zinit light zsh-users/zsh-completions

# Lazy-load zsh-history-substring-search
zinit ice wait"0b" lucid atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Lazy-load touchbar
if [[ $TERM_PROGRAM = "iTerm.app" ]] && [[ "$(uname)" == "Darwin" ]]; then
  zinit ice wait"1" lucid
  zinit light zsh-users/zsh-apple-touchbar
fi

# Lazy-load zsh-you-should-use
zinit ice wait"1" lucid
zinit light MichaelAquilina/zsh-you-should-use
export YSU_MESSAGE_POSITION="after"

# Lazy-load vi-mode
if [[ -n $TMUX ]] || [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
    zinit ice wait"1" lucid depth=1
    zinit light jeffreytse/zsh-vi-mode
fi

##########################################################
##### Installing Command-Line Tools and load it                                                 
##########################################################
# Lazy-load lsd
# https://github.com/lsd-rs/lsd
zinit ice wait"0a" lucid from"gh-r" as"program" pick"*/lsd"
zinit light lsd-rs/lsd

# Lazy-load zoxide
zinit ice wait"0a" lucid from"gh-r" as"program" atclone"./zoxide init zsh > init.zsh" atpull"%atclone" src"init.zsh" 
zinit light ajeetdsouza/zoxide

# Lazy-load fd
zinit ice wait"0a" lucid from"gh-r" as"program" pick"*/fd"
zinit load sharkdp/fd

# Lazy-load bat
# zinit ice wait"0a" lucid from"gh-r" as"program" pick"*/bat"
# zinit load sharkdp/bat

if [[ -n $TMUX ]] || [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  # Lazy-load fzf
  zinit ice wait"0a" lucid from="gh-r" as"program" atload"source <(fzf --zsh); bindkey '^R' fzf-history-widget; bindkey '^T' fzf-file-widget"
  zinit light junegunn/fzf
  
  export FZF_CTRL_T_OPTS=$FZF_CTRL_T_OPTS" 
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
  
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
  --reverse
  --border
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header '按 CTRL-Y 拷贝命令到剪切板'"

  # Lazy-load mcfly
  # https://github.com/cantino/mcfly
  zinit ice wait"0b" lucid from"gh-r" as"program" atload'eval "$(mcfly init zsh)"; bindkey "^Y" mcfly-history-widget; bindkey "^R" fzf-history-widget'
  zinit light cantino/mcfly
  # To swap the color scheme 
  [[ "$(defaults read -g AppleInterfaceStyle 2&>/dev/null)" != "Dark" ]] && export MCFLY_LIGHT=true
  export MCFLY_KEY_SCHEME=vim
  # Fuzzy searching, 0 is off, [2-5] is best
  export MCFLY_FUZZY=2
  # Change interface view, options: top、 bottom
  export MCFLY_INTERFACE_VIEW=bottom
  # Data source
  export MCFLY_HISTORY=~/.zsh_history
  # Results count
  export MCFLY_RESULTS=50
  # Results sorting, options: rank、last_run
  export MCFLY_RESULTS_SORT=last_run
  # Custom prompt, default: $, ❯
  export MCFLY_PROMPT=""
  # Search only the latest 10000 entries
  MCFLY_HISTORY_LIMIT=10000
  # Pause used
  # unset MCFLY_HISTORY
fi

##########################################################
##### Load powerlevel10k theme                                                  
##########################################################
# Load powerlevel10k theme
# https://github.com/romkatv/powerlevel10k
zinit ice depth"1" atload"source ~/.p10k.zsh"
zinit light romkatv/powerlevel10k

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

# setopt sharehistory
