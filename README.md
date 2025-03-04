# 终端配置

- 准备
- Homebrew
- omz + zinit + p10k

## 准备

``` powershell
# 解析 raw.githubusercontent.com 为 ip
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hahapigs/work-theme/refs/heads/main/setup_hosts.sh)"
```

如果 <code>raw.githubusercontent.com</code> 无法直接访问，可以手动执行

``` powershell
git clone https://github.com/hahapigs/work-theme.git ~/Github/work-theme
sh ~/Github/work-theme/setup_hosts.sh
```

验证

``` powershell
# 查看域名解析是否正确，/etc/hosts 是 /private/etc/hosts 影射，不可修改
cat /etc/hosts | grep -i 'github'

# 查看访问情况
# curl
curl -Iv --max-time 5 https://raw.githubusercontent.com
# telenet
nc -vz raw.githubusercontent.com 443
```

## Homebrew

#### install

``` powershell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### uninstall

``` powershell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

说明：详细参看 <a href="https://github.com/Homebrew/install?tab=readme-ov-file">Homebrew</a>

## omz + zinit + p10k

#### omz install

```powershell
sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
```

#### omz uninstall

```powershell
# 如果加载了 /lib/cli.zsh，可以直接使用 omz uninstall
omz uninstall
# 手动执行
$ZSH/tools/uninstall.sh
```

说明：详细参看 <a href="https://github.com/ohmyzsh/ohmyzsh">oh-my-zsh</a>

#### 自动安装

```powershell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hahapigs/work-theme/refs/heads/main/install.sh)"
```

#### 手动安装

```powershell
git clone https://github.com/hahapigs/work-theme.git ~/Github/work-theme
sh ~/Github/work-theme/install.sh
```