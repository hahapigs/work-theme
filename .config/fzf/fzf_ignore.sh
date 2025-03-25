#!/bin/bash

# 定义 .FZF_IGNORE 文件的位置
FZF_IGNORE_FILE="${FZF_HOME}/.fzfignore"

_read_fzf_ignore() {

  local tool="$1"

  # 检查文件是否存在
  if [[ ! -f $FZF_IGNORE_FILE ]]; then
    echo "Error: $FZF_IGNORE_FILE not found!"
    exit 1
  fi

  if [[ "$tool" == "fd" ]]; then
    # 读取 .fdignore 文件，过滤掉注释和空行，并连接为一行
    echo $(grep -v '^\s*#' "$FZF_IGNORE_FILE" | grep -v '^\s*$' | sed "s|^|--exclude '|; s|$|'|" | tr '\n' ' ')
  elif [[ "$tool" == "find" ]]; then
    # 读取 .fdignore 文件，过滤掉注释和空行，并连接为一行
    echo $(grep -v '^\s*#' "$FZF_IGNORE_FILE" | grep -v '^\s*$' | sed "s|^|-not -path '|; s|$|'|" | tr '\n' ' ')
  else
    echo "Error: Unsupported tool '$tool'. Use 'fd' or 'find'." >&2
    exit 1
  fi

}

_read_fzf_ignore "$1"
