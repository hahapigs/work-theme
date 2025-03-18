######################################################################################################################################
##### github: https://github.com/zdharma-continuum/zinit
##### wiki: https://zdharma-continuum.github.io/zinit/wiki/
######################################################################################################################################

##########################################################
##### Install `zinit` and load it
##########################################################
## MacOS (Homebrew)
# [[ ! command -v zinit ]] && brew install zinit
[[ ! -d $(brew --prefix zinit) ]] && brew install zinit
source $(brew --prefix zinit)/zinit.zsh

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
# NOTE: WarpTerminal 不支持
zinit snippet OMZP::sudo

# Lazy-load copypath
zinit ice wait"0a" lucid
zinit snippet OMZP::copypath

# Lazy-load copybuffer, bindkey "^O" copybuffer
# NOTE: WarpTerminal 不支持
zinit ice wait"0a" lucid
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
# NOTE: fzf-tab 对加载顺序有要求，需要将它放在 compinit 之后、zsh-autosuggestions 和 fast-syntax-highlighting 和 zsh-syntax-highlighting 之前加载，否则会导致 tab 快捷键无效
# NOTE: 如果有更强大的`amazon-q`，不需要开启此插件，但是`amazon-q`截止现在仅支持`terminal`,`hyper`,`iterm2`,`vscode`
# NOTE: WarpTerminal 不支持，且只在 `tmux` 模式下有效
zinit ice wait"0a" lucid
zinit light Aloxaf/fzf-tab

# Lazy-load zsh-autosuggestions with priority loading
# Changed wait to "0a" to load before syntax highlighting
# NOTE: 没有 atload='!_zsh_autosuggest_start' 会影响首个 prompt 失去提示功能
zinit ice wait"0a" lucid atload='!_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Lazy-load syntax highlighting AFTER autosuggestions
# Changed wait to "0b" to ensure proper order
zinit ice wait"0c" lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting       # zsh-users/zsh-syntax-highlighting 更新滞后

# Lazy-load zsh-completions
zinit ice wait"0a" lucid blockf
zinit light zsh-users/zsh-completions

# Lazy-load zsh-history-substring-search
zinit ice wait"0a" lucid atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Lazy-load touchbar
# zinit ice wait"1" lucid if"[[ \$TERM_PROGRAM = 'iTerm.app' ]] && [[ \$(uname) == 'Darwin' ]]"
# zinit light zsh-users/zsh-apple-touchbar

# Lazy-load zsh-you-should-use
zinit ice wait"1" lucid
zinit light MichaelAquilina/zsh-you-should-use
export YSU_MESSAGE_POSITION="after"

# Lazy-load vi-mode
# 🐛 NOTE: 此插件会导致其他插件快捷键绑定问题（暂时注释）
# zinit ice wait"0" lucid if"[[ -n \$TMUX ]] || [[ \$TERM_PROGRAM != 'WarpTerminal' ]]" depth=1
# zinit light jeffreytse/zsh-vi-mode

# Lazy-load fzf-git
# https://github.com/junegunn/fzf-git.sh
zinit ice wait"0c" lucid pick"fzf-git.sh"
zinit light junegunn/fzf-git.sh

# Lazy-load forgit
# https://github.com/wfxr/forgit
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

##########################################################
##### ZSH Basic Options
##########################################################
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
