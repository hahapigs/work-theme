#!/bin/bash
set -e # 脚本执行出错时自动退出


# Github 主题目录
GITHUB_P10K="https://raw.githubusercontent.com/hahapigs/work-theme/refs/heads/main/theme---p10k/"
P10K_FILE="$HOME/.p10k.zsh"

# 选择主题
function choice_theme() {
  options=("A" "B")
  # 架构
  architecture=(".p10k.zsh" ".p10k-WarpTerminal.zsh")

  # Prompt the user to choose from A or B
  echo "请选择您想要的主题："
  for index in ${!options[@]}; do
    echo "${options[index]}. ${architecture[index]}"
    option=${options[index]}
    eval "${option}=${architecture[index]}"
  done

  echo "Q: 取消"

  flag=0
  while [ $flag -ne 1 ]; do
    # User selection
    read -p "Enter your choice (A or B): " choice

    # Check user choice and display the selected line
    case $choice in
      A | a)
        GITHUB_P10K="${GITHUB_P10K}$A"
        flag=1
      ;;
      B | b)
        GITHUB_P10K="${GITHUB_P10K}$B"
        flag=1
      ;;
      Q | q)
        exit 0
      ;;
      *) echo "无效的输入，请重新输入";;
    esac
  done
}


# 下载配置
function download_conf() {
  local target_file=$1
  local github_url=$2

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
  if ! curl -sfL "$github_url" -o "$target_file"; then
    echo "错误：文件下载失败，请检查以下可能："
    echo "1. 网络连接是否正常"
    echo "2. GitHub 文件地址是否正确: $github_url"
    exit 1
  fi
  echo "文件已成功下载至: $target_file"
}


function main() {
  # 选择 .p10k 主题
  choice_theme
  # 下载 .p10k 主题
  download_conf $P10K_FILE $GITHUB_P10K
}

main

echo "\n所有操作已完成！建议执行以下命令："
echo "source ~/.zshrc"
