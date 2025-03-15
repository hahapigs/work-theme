#!/bin/zsh
# Note: The first added entry gets referenced last
if command -v getconf &> /dev/null; then
  PATH="$(getconf PATH)"
fi

# Prepend PATH by skipping duplicates
declare -U PATH
prepend() {
  [ -d "$1" ] && PATH="$1:$PATH"
}

# Obtain the Homebrew prefix using `BREW_PREFIX`  based on the operating system
if [[ "$(uname -s)" == "Darwin" ]]; then
  if [[ "$(uname -m)" == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"  # Apple Silicon
  else
    BREW_PREFIX="/usr/local"     # Intel
  fi
elif [[ "$(uname -s)" == "Linux" ]]; then
  BREW_PREFIX="/home/linuxbrew/.linuxbrew"  # Linux
else
  echo "The BREW_PREFIX environment variable is incorrect."
fi

# > $(brew --prefix)
prepend "$BREW_PREFIX/bin"
prepend "$BREW_PREFIX/sbin"

# Jenv
prepend "$HOME/.jenv/bin"
eval "$(jenv init -)"

# Custom dotfiles binaries
prepend "$/dotfiles/bin/lib"
prepend "$HOME/dotfiles/bin"

# User binaries
prepend "$HOME/bin"

# Prevent it from being used accidentally elsewhere in the script or by other scripts
unset prepend

export PATH
