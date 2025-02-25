#!/bin/bash

# 确保脚本在出错时退出
set -e

# 检查是否为 root 用户，如果不是则提示用户输入密码
if [ "$(id -u)" -ne 0 ]; then
    echo "需要管理员权限，请输入密码..."
    sudo -v
fi

# 设置 DNS 为 8.8.8.8 和 4.4.4.4
echo "设置 DNS 为 8.8.8.8 和 4.4.4.4..."
networksetup -setdnsservers Wi-Fi 8.8.8.8 4.4.4.4 || {
    echo "设置 DNS 失败！"
    exit 1
}

# 获取 raw.githubusercontent.com 的 IP 地址
echo "获取 raw.githubusercontent.com 的 IP 地址..."
ip_address=$(nslookup raw.githubusercontent.com | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | tail -n 4)

# 将 IP 地址写入 /private/etc/hosts 文件
echo "将 IP 地址写入 /private/etc/hosts 文件..."
# 如果需要将所有的 IP 地址都写入，可以使用循环
for ip in $ip_address; do
    echo "$ip raw.githubusercontent.com" | sudo tee -a /private/etc/hosts > /dev/null  {
        echo "写入 hosts 文件失败！"
        exit 1
    }
done


# 移除网络中的 DNS 设置
echo "移除网络中的 DNS 设置..."
networksetup -setdnsservers Wi-Fi empty || {
    echo "移除 DNS 设置失败！"
    exit 1
}

# 测试访问 raw.githubusercontent.com
echo "测试访问 raw.githubusercontent.com..."
curl -Iv --max-time 5 https://raw.githubusercontent.com || {
    echo "访问 raw.githubusercontent.com 失败！"
    exit 1
}

# 完成
echo "脚本执行完成！"
exit 0
