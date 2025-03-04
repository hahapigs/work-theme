#!/bin/bash
set -e # 脚本执行出错时自动退出

# ========== 验证 fzf 安装 ==========
# 定义可能的安装脚本路径
fzf_home="$HOME/.local/share/zinit/plugins/junegunn---fzf/install"
# 安装 faf
function install_faf() {
  echo "验证 fzf 安装..."
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

install_faf
