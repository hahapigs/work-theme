# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.pre.bash"

## PATH
# export PATH="$PATH:/usr/local/sbin"

##########################################################
## Homebrew Environment Variables
##########################################################
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
export HOMEBREW_CASK_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-cask.git"
export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

##########################################################
## Lazygit Environment Variables
##########################################################
# https://github.com/jesseduffield/lazygit/
# 查看默认位置lazygit -cd
# 覆盖默认文件位置 lazygit -ucf ~/.config/lazygit/config.yml
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

##########################################################
## Lazydocker Environment Variables
##########################################################
# https://github.com/jesseduffield/lazydocker
export LAZYDOCKER_CONFIG="$HOME/.config/lazydocker/config.yml"

##########################################################
## Go Environment Variables
##########################################################
export GO111MODULE=on
export GOPROXY=https://mirrors.aliyun.com/goproxy/ 
# export GOOS=linux

##########################################################
## Laguage Environment Variables
##########################################################
export LANG="zh_CN.UTF-8"
export LC_COLLATE="zh_CN.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
export LC_MESSAGES="zh_CN.UTF-8"
export LC_MONETARY="zh_CN.UTF-8"
export LC_NUMERIC="zh_CN.UTF-8"
export LC_TIME="zh_CN.UTF-8"
export LC_ALL=

##########################################################
## Basic Environment Variables
##########################################################
alias ls="lsd"                  # list all files and directories
alias ll="ls -l"                # list all files and directories in long format
alias lla="ll -a"               # list all files and directories in long format, including hidden ones
alias lt="ls --tree"            #
alias c="clear"                 # clear the screen
# alias qq="exit"               # exit the terminal
alias mkdir="mkdir -pv"         # create directories with verbose output
alias cp="cp -iv"               # copy files interactively with verbose output
alias mv="mv -iv"               # move files interactively witch verbose output
alias rm="rm -iv"               # remove files interactively with verbose output
alias rmdir="rmdir -v"          # remove directories with verbose output
alias grep="grep --color=auto"  # highlight search matches
alias fgrep="fgrep --color=auto"    # hightlight fixed string matches
alias egrep="egrep --color=autp"    # hightlight extended regex matches

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.post.bash"
