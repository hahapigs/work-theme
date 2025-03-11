##########################################################
##### Mcfly Options
##########################################################
# To swap the color scheme
[[ "$(defaults read -g AppleInterfaceStyle 2&>/dev/null)" != "Dark" ]] && export MCFLY_LIGHT=true
export MCFLY_KEY_SCHEME=vim
# Fuzzy searching, 0 is off, [2-5] is best
export MCFLY_FUZZY=2
# Change interface view, options: top、 bottom
export MCFLY_INTERFACE_VIEW=bottom
# Data source
export MCFLY_HISTORY=~/.zsh_history
# Results count
export MCFLY_RESULTS=50
# Results sorting, options: rank、last_run
export MCFLY_RESULTS_SORT=last_run
# Custom prompt, default: $, ❯
export MCFLY_PROMPT=""
# Search only the latest 10000 entries
MCFLY_HISTORY_LIMIT=100000
# Pause used
# unset MCFLY_HISTORY
