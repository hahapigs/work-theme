# Note: The first added entry gets referenced last
if command -v getconf &> /dev/null; then
  PATH="$(getconf PATH)"
fi

# Prepend PATH by skipping duplicates
declare -U PATH PATH
prepend() {
  [ -d "$1" ] && PATH="$1:$PATH"
}

# Obtain the Homebrew prefix using `brewprefix`  based on the operating system
if [[ "$(uname -s)" == "Darwin" ]]; then
  if [[ "$(uname -m)" == "arm64" ]]; then
    brewprefix="/opt/homebrew"  # Apple Silicon
  else
    brewprefix="/usr/local"     # Intel
  fi
elif [[ "$(uname -s)" == "Linux" ]]; then
  brewprefix="/home/linuxbrew/.linuxbrew"  # Linux
else
  echo "The brew-prefix environment variable is incorrect."
fi

# Homebrew
# > $(brew --prefix)
prepend "$brewprefix/bin"
prepend "$brewprefix/sbin"

# Jenv
prepend "$HOME/.jenv/bin"

# Custom dotfiles binaries
prepend "$HOME/.config/zsh/bin"

# Prevent it from being used accidentally elsewhere in the script or by other scripts
unset brewprefix
unset prepend

export PATH
export FPATH
