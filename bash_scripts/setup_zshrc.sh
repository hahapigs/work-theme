#!/bin/bash
set -e # 脚本执行出错时自动退出

# ========== 预处理：检测插件安装情况 ==========
# zinit
zinit_dir="$(brew --prefix zinit)"
# autojump
autojump_dir="$(brew --prefix autojump)"
# lsd
lsd_dir="$(brew --prefix lsd)"
# 检测插件安装情况
function check_pre_install() {
  # 检测路径是否存在并安装
  if [ -d "$zinit_dir" ]; then
    echo "✅ zinit 已安装"
  else
    echo "❌ zinit 未安装"
    exit 1
  fi
  
  # 检测路径是否存在并安装
  if [ -d "$autojump_dir" ]; then
    echo "✅ autojump 已安装"
  else
    echo "❌ autojump 未安装"
    exit 1
  fi
  
  # 检测路径是否存在并安装
  if [ -d "$lsd_dir" ]; then
    echo "✅ lsd 已安装"
  else
    echo "❌ lsd 未安装"
    exit 1
  fi
}

# ========== 第一部分：处理 .zshrc 文件 ==========
# 复制配置
function copy_conf() {
  
  local source_file=$1
  local target_file=$2

  # 检测文件是否存在并处理
  if [ -f "$target_file" ]; then
    echo "\n检测到已存在 $target_file 文件"
    read -p "请选择操作：[B]备份后复制/[O]直接覆盖/[Q]取消 (B/O/Q) " action
    
    case $action in
      [Bb]*) 
        # 生成带时间戳的备份文件
        backup_file="$target_file.bak.$(date +%Y%m%d%H%M%S)"
        cp -v "$target_file" "$backup_file"
        echo "已备份原文件至: $backup_file"
        ;;
      [Oo]*) 
        echo "直接覆盖原文件..."
        ;;
      [Qq]*) 
        echo "操作已取消"
        exit 0
        ;;
      *) 
        echo "无效输入，操作取消"
        exit 1
        ;;
    esac
  fi

  # 复制文件并检查结果
  echo "正在复制文件 ..."
  if ! cp $source_file $target_file; then
    echo "错误：复制文件失败，请检查以下可能："
    echo "1. 被复制的文件是否存在 $source_file"
    echo "2. 要保存的文件是否正确 $target_file"
    exit 1
  fi
  echo "文件已成功复制至: $target_file"
}

# 预处理
check_pre_install
# 拷贝 oh-my-zsh 配置
copy_conf "../.zshrc" "$HOME/.zshrc"
# 拷贝 .zinit.zsh 配置
copy_conf "../zsh/zinit/.zinit.zsh" "$HOME/.config/zsh/zinit/.zinit.zsh"
# 拷贝 .bash_profile 配置
copy_conf "../.bash_profile" "$HOME/.bash_profile"
