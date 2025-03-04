#!/bin/bash
set -e # 脚本执行出错时自动退出

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


# ========== 第二部分：复制主题和数据 ==========
p10k_theme=""
# 选择主题
function choice_theme() {
  options=("A" "B")
  # 架构
  architecture=("rainbow" "ginkgo")

  # Prompt the user to choose from A or B
  echo "\n请选择您想要的主题："
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
        p10k_theme=".p10k-$A.zsh"
        flag=1
      ;;
      B | b)
        p10k_theme=".p10k-$B.zsh"
        flag=1
      ;;
      Q | q)
        exit 0
      ;;
      *) echo "无效的输入，请重新输入";;
    esac
  done
}

# 复制文件夹
function copy_dir {
  
  local source_dir=$1
  local target_dir=$2
  
  # 复制文件并检查结果
  echo "正在复制 $source_dir  ..."
  if ! cp -r $source_dir $target_dir; then
    echo "错误：复制文件失败，请检查以下可能："
    echo "1. 被复制的目录是否存在 $source_dir"
    echo "2. 要保存的目录是否正确 $target_dir"
    exit 1
  fi
  echo "文件已成功复制至: $target_dir"
}

# 选择主题
choice_theme
# 拷贝主题
copy_conf "./theme---p10k/$p10k_theme" "$HOME/.p10k.zsh"
# 拷贝主题数据
copy_dir "./theme---p10k/.p10k-data" $HOME
