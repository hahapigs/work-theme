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
target_file="$HOME/.zshrc"
source_url="https://raw.githubusercontent.com/hahapigs/work-theme/main/.zshrc"
# 下载配置
function download_conf() {
  # 检测文件是否存在并处理
  if [ -f "$target_file" ]; then
    echo "检测到已存在 $target_file 文件"
    read -p "请选择操作：[B]备份后下载/[O]直接覆盖/[Q]取消 (B/O/Q) " action
    
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

  # 下载文件并检查结果
  echo "正在从 GitHub 下载文件"
  if ! curl -sfL "$source_url" -o "$target_file"; then
    echo "错误：文件下载失败，请检查以下可能："
    echo "1. 网络连接是否正常"
    echo "2. GitHub 文件地址是否正确: $source_url"
    exit 1
  fi
  echo "文件已成功下载至: $target_file"
}


# ========== 第二部分：验证 fzf 安装 ==========
# 定义可能的安装脚本路径
fzf_home="$HOME/.local/share/zinit/plugins/junegunn---fzf/install"
# 安装 faf
function install_faf() {
  echo "\n验证 fzf 安装..."
  if ! command -v fzf &> /dev/null; then
    echo "检测到 fzf 未安装"
    # 检查安装脚本是否存在
    if [ ! -f "$fzf_home" ]; then
      echo "错误：找不到 fzf 安装脚本，请检查以下路径："
      echo "$fzf_home"
      echo "可能原因：尚未通过 zinit 安装 fzf 插件"
      exit 1
    fi
    
    # 执行安装脚本
    echo "正在运行 fzf 安装脚本..."
    if ! bash "$fzf_home"; then
      echo "错误：fzf 安装失败，您可以尝试以下方法："
      echo "1. 手动安装: https://github.com/junegunn/fzf#installation"
      echo "2. 检查安装脚本权限: chmod +x '$fzf_home'"
      exit 1
    fi
    
    # 二次验证安装结果
    if ! command -v fzf &> /dev/null; then
      echo "警告：安装脚本执行完成但 fzf 仍不可用"
      echo "建议：重新登录终端或手动添加环境变量"
    else
      echo "fzf 已成功安装！"
    fi
  else
    echo "fzf 已正确安装：$(which fzf)"
  fi
}


function main() {
  # 预处理
  check_pre_install
  # 下载 .zshrc 配置
  download_conf 
  # 检测及安装 fzf
  install_faf 
}

main

echo "\n所有操作已完成！建议执行以下命令："
echo "source ~/.zshrc"
