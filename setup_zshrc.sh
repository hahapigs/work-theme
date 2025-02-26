#!/bin/bash
set -e # 脚本执行出错时自动退出

# ========== 预处理：检测 zinit 插件 ==========
# zinit
ZINIT_DIR="$(brew --prefix zinit)"
# autojump
AUTOJUMP_DIR="$(brew --prefix autojump)"
# lsd
LSD_DIR="$(brew --prefix lsd)"

# 检测路径是否存在并安装
if [ -d "$ZINIT_DIR" ]; then
  echo "✅ zinit 已安装"
else
  echo "❌ zinit 未安装"
  exit 1
fi

# 检测路径是否存在并安装
if [ -d "$AUTOJUMP_DIR" ]; then
  echo "✅ autojump 已安装"
else
  echo "❌ autojump 未安装"
  exit 1
fi

# 检测路径是否存在并安装
if [ -d "$LSD_DIR" ]; then
  echo "✅ lsd 已安装"
else
  echo "❌ lsd 未安装"
  exit 1
fi

# ========== 第一部分：处理 .zshrc 文件 ==========
TARGET_FILE="$HOME/.zshrc"
GITHUB_ZSHRC="https://raw.githubusercontent.com/hahapigs/work-theme/main/.zshrc"

# 检测文件是否存在并处理
if [ -f "$TARGET_FILE" ]; then
  echo "检测到已存在 $TARGET_FILE 文件"
  read -p "请选择操作：[B]备份后下载/[O]直接覆盖/[Q]取消 (B/O/Q) " action
  
  case $action in
    [Bb]*) 
      # 生成带时间戳的备份文件
      backup_file="$TARGET_FILE.bak.$(date +%Y%m%d%H%M%S)"
      cp -v "$TARGET_FILE" "$backup_file"
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
echo "正在从 GitHub 下载 .zshrc..."
if ! curl -sfL "$GITHUB_ZSHRC" -o "$TARGET_FILE"; then
  echo "错误：文件下载失败，请检查以下可能："
  echo "1. 网络连接是否正常"
  echo "2. GitHub 文件地址是否正确: $GITHUB_ZSHRC"
  exit 1
fi
echo "文件已成功下载至: $TARGET_FILE"

# ========== 第二部分：验证 fzf 安装 ==========
echo "\n验证 fzf 安装..."
if ! command -v fzf &> /dev/null; then
  echo "检测到 fzf 未安装"
  
  # 定义可能的安装脚本路径
  install_script="$HOME/.local/share/zinit/plugins/junegunn---fzf/install"
  
  # 检查安装脚本是否存在
  if [ ! -f "$install_script" ]; then
    echo "错误：找不到 fzf 安装脚本，请检查以下路径："
    echo "$install_script"
    echo "可能原因：尚未通过 zinit 安装 fzf 插件"
    exit 1
  fi
  
  # 执行安装脚本
  echo "正在运行 fzf 安装脚本..."
  if ! bash "$install_script"; then
    echo "错误：fzf 安装失败，您可以尝试以下方法："
    echo "1. 手动安装: https://github.com/junegunn/fzf#installation"
    echo "2. 检查安装脚本权限: chmod +x '$install_script'"
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

echo "\n所有操作已完成！建议执行以下命令："
echo "source ~/.zshrc"
