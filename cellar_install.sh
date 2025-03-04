#!/bin/bash
set -e # 脚本执行出错时自动退出

# ========== 目录跳转和显示 ==========
# lsd (colorls在mac上安装需要先安装ruby，推荐安装lsd)
brew install lsd
# exa
brew install exa
# broot
brew install broot


# ========== 网络管理 ==========
brew install curl

brew install curlie

brew install wget

brew install httpie

brew install mtr

brew install telnet
# 基于 traceroute 和 tracepath 命令
brew install nexttrace

# ========== 磁盘线程性能显示 ==========

brew install dust

brew install duf

brew install procs

brew install bottom

brew install btop

brew install htop

brew install glances


# ========== 查找工具 ==========

brew install fzf

brew install mcfly


# choose  choose-gui  choose-rust
brew install choose


# diff 的替代品
brew install diff-so-fancy

# atuin 历史记录管理工具，支持多端同步
brew install atuin
