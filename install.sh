#!/bin/bash
set -e # 脚本执行出错时自动退出

sh setup_zshrc.sh
echo
sh setup_p10k.sh

echo "\n所有操作已完成！建议执行以下命令："
echo "source ~/.zshrc && sh setup_fzf.sh"
