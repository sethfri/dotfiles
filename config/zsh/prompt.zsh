# prompt settings

source $HOME/Developer/mac-setup/config/zsh/git-prompt

setopt prompt_subst

function cpu_prompt_info {
  local cpu_info=$(sysctl -n machdep.cpu.brand_string)
  local arch_name=$(arch)
  # Warn if we're on an M1, but using an Intel shell
  if [[ "$cpu_info" = "Apple M1" ]] && [[ "$arch_name" != "arm64" ]]; then
    echo "${PR_BOLD_RED}[INTEL]%F{reset} "
  fi
}

# Make this look the same as the bash prompt
PROMPT="$(cpu_prompt_info)%F{251}%~%F{reset}%B%F{cyan}\$(__git_ps1 \" %s\")%F{reset}%b "

export GIT_PS1_SHOWDIRTYSTATE=true

# If you want the old zsh prompt then add the following to your ~/.zshrc file
#
# function git_prompt_info {
#   local ref=$(git symbolic-ref HEAD 2> /dev/null)
#   if [[ -n $ref ]]; then
#     echo "${PR_CYAN}(${ref#refs/heads/}$remote$state${PR_CYAN})${PR_WHITE}"
#   fi
# }
#
# export PS1='${SSH_CONNECTION+"%{$fg_bold[cyan]%}%n@%m:"}%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info):%? '
