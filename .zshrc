# zmodload zsh/zprof

# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git sudo cp copypath z)

# source $ZSH/oh-my-zsh.sh
source ~/.bash_profile

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"source /Users/zhaohongliang/.zshrc

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# [[ $TERM_PROGRAM = "WarpTerminal" ]] && source ~/.p10k-WrapTerminal.zsh
# [[ $TERM_PROGRAM = "iTerm.app" ]] && source ~/.p10k-iTerm.zsh
# [[ $TERM_PROGRAM = "Hyper" ]] && source ~/.p10k-Hyper.zsh
# [[ $TERM_PROGRAM = "waveterm" ]] && source ~/.p10k.zsh
# [[ $TERM_PROGRAM = "WezTerm" ]] && source ~/.p10k-WezTerm.zsh

# 加载 zinit
source /usr/local/opt/zinit/zinit.zsh

# 加载 Oh My Zsh 库
# zinit snippet https://github.com/ohmyzsh/ohmyzsh/tree/master/lib/git.zsh
# zinit snippet OMZ::lib/git.zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZL::cli.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::key-bindings.ZSH
zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZL::directories.zsh

# 延迟加载 git 插件
zinit ice wait"0" lucid
zinit snippet OMZP::git/git.plugin.zsh

# 延迟加载 z 插件
zinit ice wait"0" lucid
zinit snippet OMZP::z/z.plugin.zsh

# 延迟加载 sudo 插件
zinit ice wait"0" lucid
zinit snippet OMZP::sudo/sudo.plugin.zsh

# 延迟加载 copypath 插件
zinit ice wait"0" lucid
zinit snippet OMZP::copypath/copypath.plugin.zsh

# 延迟加载 copypath 插件
zinit ice wait"0" lucid
zinit snippet OMZP::dash/dash.plugin.zsh

# 延迟加载插件
# zinit ice wait"1" lucid
# zinit light romkatv/zsh-defer

# 延迟加载 fzf
zinit ice wait"0" lucid
zinit light junegunn/fzf

# 延迟加载 fzf-tab 补全
zinit ice wait"0" lucid
zinit light Aloxaf/fzf-tab

# 延迟加载代码提示功能
# 没有 atload='_zsh_autosuggest_start' 会影响首个 prompt 失去提示功能
zinit ice wait"0" lucid atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# 延迟加载语法高亮功能
zinit ice wait"0" lucid atinit="zicompinit"
zinit light zdharma-continuum/fast-syntax-highlighting
# zinit light zsh-users/zsh-syntax-highlighting

# 加载自动补全功能
zinit ice wait"0" lucid
zinit light zsh-users/zsh-completions

# 延迟加载搜索历史功能
zinit ice wait"0" lucid atinit="ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zsh-users/zsh-history-substring-search

# 延迟加载苹果 touchbar
if [[ $TERM_PROGRAM = "iTerm.app" ]]; then
  zinit ice wait"1" lucid
  zinit light zsh-users/zsh-apple-touchbar
fi

# 优化加载 powerlevel10k
zinit ice depth"1" atload"source ~/.p10k.zsh"
zinit light romkatv/powerlevel10k

setopt sharehistory

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh  ] && . /usr/local/etc/profile.d/autojump.sh

# z
# [ -f /usr/local/etc/profile.d/z.sh  ] && . /usr/local/etc/profile.d/z.sh

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

