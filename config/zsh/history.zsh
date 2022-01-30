# history settings
export HISTFILE=~/.zhistory   # History savefile location
export HISTSIZE=1000000       # Number of history items to save in memory
export SAVEHIST=$HISTSIZE     # Number of history items to save in file
setopt SHARE_HISTORY          # Share history across multiple zsh sessions
setopt APPEND_HISTORY         # Multiple sessions append to same history file (rather than last)
setopt INC_APPEND_HISTORY     # Add history items immediately, not when the session exits
setopt HIST_IGNORE_ALL_DUPS   # When adding a new entry delete older duplicates
setopt HIST_IGNORE_DUPS       # Don't add a new entry if it's an immediate duplicate
setopt HIST_REDUCE_BLANKS     # Remove blank lines from history
