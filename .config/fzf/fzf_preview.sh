#!/bin/bash

# 获取 fzf 传递的文件或目录路径
target="$1"

# 如果是文件
if [[ -f "$target" ]]; then
  # 使用 bat 显示文件内容（带行号和语法高亮）
  bat --style numbers,changes --color always "$target" 2>/dev/null || cat "$target"
# 如果是目录
elif [[ -d "$target" ]]; then
  # 使用 eza 显示目录树（带图标）
  eza -al --tree --level 2 --icons always --color always --git --git-ignore --ignore-glob '*.py[co]' --ignore-glob '__pycache__' "$target" 2>/dev/null ||
  # 如果 eza 不可用，使用 exa 显示目录树
  exa -al --tree --level 2 --icons always --color always --git --git-ignore --ignore-glob '*.py[co]' --ignore-glob '__pycache__' "$target" 2>/dev/null ||
  # 如果 exa 不可用，使用 lsd 显示目录树
  lsd -al --tree --depth 2 --icon always --color always --git --git-ignore --ignore-glob '*.py[co]' --ignore-glob '__pycache__' "$target" 2>/dev/null ||
  # 如果 lsd 不可用，使用 tree 显示目录树
  tree -ahpCL 3 -I '.git' -I '*.py[co]' -I '__pycache__' -I '*.class' -I 'target' "$target" 2>/dev/null | less
# 如果不是文件也不是目录
else
  # 显示前 200 个字符
  echo "$target" 2>/dev/null | head -200
fi
