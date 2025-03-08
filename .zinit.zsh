######################################################################################################################################
##### github: https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#automatic
##### wiki: https://zdharma-continuum.github.io/zinit/wiki/
######################################################################################################################################

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
# source "${ZINIT_HOME}/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
# exec zsh

## MacOS (Homebrew)
# [[ ! command -v zinit ]] && brew install zinit
[[ ! -d $(brew --prefix zinit) ]] && brew install zinit

# Load zinit
source /usr/local/opt/zinit/zinit.zsh

## Basic
# zinit snippet <URL>                       # Raw Syntax with URL
# zinit snippet OMZ::<PATH>                 # Shorthand OMZ/ (https://github.com/ohmyzsh/ohmyzsh/raw/master/)
# zinit snippet OMZL::<PATH>                # Shorthand OMZ/lib/
# zinit snippet OMZT::<PATH>                # Shorthand OMZ/themes/
# zinit snippet OMZP::<PATH>                # Shorthand OMZ/plugins/

## The For-Syntax
# zinit wait lucid for \
#                       OMZL::git.zsh \
#   atload"unalias grv" OMZP::git \

##########################################################
##### Load Oh My Zsh's libraries
##########################################################
zinit snippet OMZL::git.zsh                 # git 命令别名
zinit snippet OMZL::cli.zsh                 # omz 命令
zinit snippet OMZL::history.zsh             # 命令行历史
zinit snippet OMZL::clipboard.zsh           # 剪切板，不加载此类库会导致 copypath 等命令无效
zinit snippet OMZL::completion.zsh          # 自动补全
zinit snippet OMZL::key-bindings.zsh        # 快捷键绑定
zinit snippet OMZL::directories.zsh         # 目录导航和管理，例如：cd ...

##########################################################
##### Load Oh My Zsh's plugins
##########################################################
# zinit snippet OMZP::git/git.plugin.zsh
zinit ice wait"0a" lucid
zinit snippet OMZP::git

# Lazy-load z
# zinit ice wait"1" lucid
# zinit snippet OMZP::z

# Lazy-load sudo
zinit ice wait"0a" lucid
zinit snippet OMZP::sudo

# Lazy-load copypath
zinit ice wait"0a" lucid
zinit snippet OMZP::copypath

# Lazy-load copybuffer, bindkey "^O" copybuffer
# 快速复制当前行命令, WarpTerminal 不支持copybuffer，但是可以通过shift+up/down实现快速选中或取消选中
zinit ice if"[[ -n '$TMUX' ]] || [[ $TERM_PROGRAM != 'WarpTerminal' ]]" wait"0a" lucid
zinit snippet OMZP::copybuffer

# Lazy-load command-not-found
# zinit ice wait"1" lucid
# zinit snippet OMZP::command-not-found

# Lazy-load dash
zinit ice wait"0a" lucid
zinit snippet OMZP::dash

##########################################################
##### Load external plugins of Oh My Zsh
##########################################################
# Lazy-load zsh-defer
# zinit ice wait"1" lucid
# zinit light romkatv/zsh-defer

# Lazy-load fzf-tab
# https://github.com/Aloxaf/fzf-tab
zinit ice wait"0a" lucid
zinit light Aloxaf/fzf-tab

# Lazy-load zsh-autosuggestions with priority loading
# Changed wait to "0a" to load before syntax highlighting
# 没有 atload='_zsh_autosuggest_start' 会影响首个 prompt 失去提示功能
zinit ice wait"0a" lucid atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Lazy-load syntax highlighting AFTER autosuggestions
# Changed wait to "0b" to ensure proper order
zinit ice wait"0c" lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting       # zsh-users/zsh-syntax-highlighting 更新滞后

# Lazy-load zsh-completions
zinit ice wait"0a" lucid
zinit light zsh-users/zsh-completions

# Lazy-load zsh-history-substring-search
zinit ice wait"0a" lucid atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Lazy-load touchbar
# zinit ice if"[[ '$TERM_PROGRAM' = 'iTerm.app' ]] && [[ '$(uname)' == 'Darwin' ]]" wait"1" lucid
# zinit light zsh-users/zsh-apple-touchbar

# Lazy-load zsh-you-should-use
zinit ice wait"1" lucid
zinit light MichaelAquilina/zsh-you-should-use
export YSU_MESSAGE_POSITION="after"

# Lazy-load vi-mode
# 🐛 会导致其他插件快捷键绑定问题（暂时注释）
# zinit ice wait"0" lucid if"[[ -n '$TMUX' ]] || [[ '$TERM_PROGRAM' != 'WarpTerminal' ]]" depth=1
# zinit light jeffreytse/zsh-vi-mode

##########################################################
##### Installing Command-Line Tools and load it
##########################################################
# Lazy-load lsd
# https://github.com/lsd-rs/lsd
zinit ice wait"0a" lucid from"gh-r" as"program" pick"*/lsd"
zinit light lsd-rs/lsd

# Lazy-load zoxide
zinit ice wait"0a" lucid from"gh-r" as"program" atclone"./zoxide init zsh > init.zsh" atpull"%atclone" src"init.zsh" atload='eval "$(zoxide init zsh)"'
zinit light ajeetdsouza/zoxide

# Lazy-load fd
zinit ice wait"0a" lucid from"gh-r" as"program" pick"*/fd"
zinit load sharkdp/fd

# Lazy-load bat
# https://github.com/sharkdp/bat
# zinit ice wait"0a" lucid from"gh-r" as"program" pick"*/bat"
# zinit load sharkdp/bat

zinit ice wait"0b" lucid if"[[ -n '$TMUX' ]] || [[ '$TERM_PROGRAM' != 'WarpTerminal' ]]" from="gh-r" as"program" atload"source <(fzf --zsh); bindkey '^R' fzf-history-widget; bindkey '^T' fzf-file-widget"
zinit light junegunn/fzf

# Lazy-load mcfly
# https://github.com/cantino/mcfly
zinit ice wait"0b" lucid if"[[ -n '$TMUX' ]] || [[ '$TERM_PROGRAM' != 'WarpTerminal' ]]" from"gh-r" as"program" atload'eval "$(mcfly init zsh)"; bindkey "^R" fzf-history-widget; bindkey "^Y" mcfly-history-widget'
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
export MCFLY_PROMPT=""
# Search only the latest 10000 entries
MCFLY_HISTORY_LIMIT=100000
# Pause used
# unset MCFLY_HISTORY

zinit ice wait"0b" lucid
zinit load wfxr/forgit

##########################################################
##### Load powerlevel10k theme
##########################################################
# Load powerlevel10k theme
# https://github.com/romkatv/powerlevel10k
zinit ice depth"1" atload"source ~/.p10k.zsh"   # git clone depth
zinit light romkatv/powerlevel10k

# Load pure theme
# zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
# zinit light sindresorhus/pure

# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
# zinit ice as"command" from"gh-r" \
#           atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#           atpull"%atclone" src"init.zsh"
# zinit light starship/starship

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


#####################
# SETOPT            #
#####################
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion
setopt completealiases        # complete alisases
setopt always_to_end          # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word       # allow completion from within a word/phrase
setopt nocorrect              # spelling correction for commands
setopt list_ambiguous         # complete as much of a completion until it gets ambiguous.
setopt nolisttypes
setopt listpacked
setopt automenu
