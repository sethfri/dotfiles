
# Path

path=(
  "$HOME/.rvm/gems/ruby-2.7.4/bin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "$HOME/bin"
  "/opt/local/bin"
  "/opt/local/sbin"
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"
)

# Projects
alias ms="$HOME/Development/mac-setup"
alias pmp="$HOME/Development/private-mac-preferences"

# Git
alias gmt='git mergetool'
alias gm='git merge'
alias gcm='git commit -v'
alias gcmm='git commit -m'
alias gcmam='git commit -am'
alias gcma='git commit -a'
alias gsa='git stash apply'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gbr='git branch'
alias gcof='git checkout $(git branch | fzf)'
alias gpush='git push'
alias gpusht='git push --tags'
alias gpull='git pull'
alias gcpc='git cherry-pick --continue'
alias gst='git status'
alias grbc='git rebase --continue'
alias gl='git log'
alias glf='git log $(git branch | fzf)'
alias gd='git diff'
alias ga='git apply -3 -p3'
alias gcmamd='git commit --amend'
alias grl='git reflog'
alias grhh='git reset --hard HEAD~1'
alias grh='git reset HEAD~1'
alias grst='git restore'

function gr() { git rebase -i --autosquash HEAD~$1; }
function grb() { GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash --autostash HEAD~$1; }

function gcmaf() {
    local target="HEAD"

    if [ -n "$1" ]; then
        target=$1
    fi

    git commit -a --fixup $target
}

function gcmf() {
    local target="HEAD"

    if [ -n "$1" ]; then
        target=$1
    fi

    git commit --fixup $target
}

function gpr() {
    if [ -n "$1" ]; then
        echo $1
        git checkout "$1"
    fi

    git pull -r
}

function fixref() {
  if [[ -z $1 ]]; then
    echo "Usage: $0 [branch_name]"
    return 1
  fi

  rm -rf .git/logs/refs/remotes/origin/"$1"
  rm -rf .git/refs/remotes/origin/"$1"
  git gc --prune=now
}

function gitfile() {
    git checkout $2 -- $1
}

# Ruby
alias be='bundle exec'

# CocoaPods
alias pu='bundle exec pod update --repo-update'
alias pio='pik && xed .'
alias nuke='rm -rf Pods/ && git clean -fff -dddd -x && dxdd && pod repo update && pik'

# Do a pod install without killing Xcode
function pi() {
  set -o pipefail

  POD_INSTALL_RESULT=$(bundle exec pod --ansi install "$@" | tee /dev/tty)

  if [[ $POD_INSTALL_RESULT == *"[!] CocoaPods could not find compatible versions for pod"* ]] \
    || [[ $POD_INSTALL_RESULT == *"[!] Unable to find a specification for"* ]]; then
    bundle exec pod install --repo-update "$@"
  fi

  if [[ $? -ne 0 ]]; then
    return 1
  fi
}

# Kill Xcode and then pod install
function pik() {
  pkill Xcode

  pi
}

# Backend
alias grad='./gradlew'
alias gb='./gradlew build'

# Helpers
alias symbolicate="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash -v"
alias dorig='find . -iname *.orig -delete'
alias ddd="rm -rf $HOME/Library/Developer/Xcode/DerivedData"
alias vs='open -a "Visual Studio Code" "$1"'

function fz() { $2 $($1 | fzf) }

# Get the list of commits that are about to be put in a PR so we can easily add a
# commit-by-commit PR description
function prl() {
    git log origin/main..HEAD --reverse --format='* %<(2)%B' | sed '/^$/d' | pbcopy
}

source "$HOME/Development/private-mac-preferences/square-zshrc"
