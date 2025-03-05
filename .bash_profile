# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.pre.bash"

##########################################################
## aliases
##########################################################

alias ls="lsd"                  # list all files and directories
alias ll="ls -l"                # list all files and directories in long format
alias lla="ll -a"               # list all files and directories in long format, including hidden ones
alias lt="ls --tree"            # 
alias c="clear"                 # clear the screen
# alias qq="exit"               # exit the terminal
alias mkdir="mkdir -pv"         # create directories with verbose output
alias cp="cp -iv"               # copy files interactively with verbose output
alias mv="mv -iv"               # move files interactively witch verbose output
alias rm="rm -iv"               # remove files interactively with verbose output
alias rmdir="rmdir -v"          # remove directories with verbose output
alias grep="grep --color=auto"  # highlight search matches
alias fgrep="fgrep --color=auto"    # hightlight fixed string matches
alias egrep="egrep --color=autp"    # hightlight extended regex matches


# 查看已安装 JDK
# /usr/libexec/java_home -V
# ls /Library/Java/JavaVirtualMachines

# 设置JDK 8
# export JAVA_8_HOME="$(/usr/libexec/java_home -v 1.8)"
# 设置JDK 9
# export JAVA_9_HOME="$(/usr/libexec/java_home -v 9)"
# 设置JDK 10 
# export JAVA_10_HOME="$(/usr/libexec/java_home -v 10)"
# 设置JDK 11
# export JAVA_11_HOME="$(/usr/libexec/java_home -v 11)"

# 设置JDK
# export JAVA_HOME="$JAVA_11_HOME"
# MAVEN_HOME
# export M3_HOME="/usr/local/Cellar/maven@3.5/3.5.4_1/libexec"

# PATH
# export PATH="$PATH:$JAVA_HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.jenv/bin"
# CLASSPATH
# export CLASSPATH="$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar"

# 映射jdk8
# alias jdk8="export JAVA_HOME=$JAVA_8_HOME"
# 映射jdk9
# alias jdk9="export JAVA_HOME=$JAVA_9_HOME"
# 映射jdk10
# alias jdk10="export JAVA_HOME=$JAVA_10_HOME"
# 映射jdk11
# alias jdk11="export JAVA_HOME=$JAVA_11_HOME"

export PATH="$PATH:/usr/local/bin:/usr/local/sbin:$HOME/.jenv/bin"
eval "$(jenv init -)"

# HomeBrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
export HOMEBREW_CASK_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-cask.git"
export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"
# HomeBrew END

export GO111MODULE=on
export GOPROXY=https://mirrors.aliyun.com/goproxy/ 
# export GOOS=linux


# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.post.bash"

