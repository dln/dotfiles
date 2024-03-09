# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone --depth=1 https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zi ice wait lucid
zi load zsh-users/zsh-completions
# zi ice wait lucid
# zi load zsh-users/zsh-autosuggestions
zi ice wait lucid
zi load zdharma-continuum/fast-syntax-highlighting
zi ice wait lucid
zi load nix-community/nix-zsh-completions
zi ice wait lucid
zi load olets/zsh-abbr
zi ice wait lucid
zi snippet https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/shrink-path/shrink-path.plugin.zsh
zinit ice depth=1; zinit light romkatv/powerlevel10k

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
 
# Highlighting
zle_highlight=('paste:none')

## History
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt HIST_IGNORE_SPACE
setopt hist_lex_words
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_subst_pattern
setopt hist_verify
setopt share_history
export HISTORY_IGNORE="(ls *|cd *|rm *|pwd|reboot|exit|e *|*AWS*|*SECRET*|*PASSWORD*|*TOKEN*|*API*|*KEY*|*PASS*|*SECRETS*|*SECRET_KEY*|*SECRET_TOKEN*|*SECRET_KEY_BASE*|*SECRET_TOKEN_BASE*)"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


## zsh settings
setopt pipe_fail
setopt auto_pushd
setopt no_beep
setopt no_rm_star_silent
setopt extended_glob
setopt ksh_glob
setopt null_glob

export LC_ALL=en_US.UTF-8

export PATH=$HOME/bin:$HOME/.cargo/bin:$PATH

redraw-prompt() {
    local precmd
    for precmd in $precmd_functions; do
        $precmd
    done
    zle reset-prompt
}
zle -N redraw-prompt

_jump() {
  _dir=$(fre --sorted | fzf-tmux --no-sort -p 90%,40% -y 0)
  [ -n "$_dir" ] && pushd $_dir >>/dev/null
  zle && zle redraw-prompt
}
zle -N _jump

fre_chpwd() {
  fre --add "$(pwd)"
}
typeset -gaU chpwd_functions
chpwd_functions+=fre_chpwd

_cwd_gitroot() {
  _gitroot=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
  _dir=$((echo "$_gitroot" && fd -td . "$_gitroot") | fzf-tmux -p 90%,40% -y 0)
  [ -n "$_dir" ] && cd $_dir
  zle && zle redraw-prompt
}
zle -N _cwd_gitroot

## Keybindings
source $HOME/.zsh/history.zsh
bindkey -e
bindkey '^g' _jump
# bindkey '^P' atuin-up-search
bindkey '^p' my-history-prefix-search-backward-widget
bindkey '^n' my-history-prefix-search-forward-widget
bindkey "^[[A" my-history-prefix-search-backward-widget
bindkey "^[[B" my-history-prefix-search-forward-widget


## Pager
export LESS="--mouse --wheel-lines=1 -nRXF"
export LESSCOLORIZER="bat"
export LESSOPEN="|lesspipe.sh %s"
export PAGER="bat"
export BAT_PAGER="less -r"

## Clipboard OSC 52
 function clip { echo -en "\x1b]52;c;$(base64 -w0)\x07" }

## Aliases
alias c='cut -c-${COLUMNS}'
alias e='tmux-edit-helper'
alias dotgit='git --work-tree $HOME --git-dir $HOME/.dot_git'
alias git='git-branchless wrap --'
alias l='bat --wrap=never --pager="less -S"'
alias ls=eza
alias tail='tail -n $LINES'
alias timestamp='TZ=Z date "+%Y%m%dT%H%M%SZ"'
alias top='btm --basic --enable_cache_memory --enable_gpu_memory --battery'
alias v=vgrep
alias ve='env EDITOR= vgrep -s'
alias xc=clip
alias w="history -1 | sed -e 's/[0-9]*  //' | xargs viddy -n1"

## ripgrep 
export RIPGREP_CONFIG_PATH=${HOME}/.config/shelman-theme/current/rg/rg.conf


tree() {
   eza --tree --color=always "$@" | bat --wrap=never
}

# "auto paging"
rg() {
  /usr/bin/rg -p "$@" | bat
}


## Prompt
# setopt TRANSIENT_RPROMPT
# eval "$(starship init zsh)"

## vim
export EDITOR=nvim

## fzf
export FZF_TMUX=1
export FZF_COMPLETION_TRIGGER=";"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
. /usr/share/fzf/completion.zsh
. /usr/share/fzf/key-bindings.zsh

## direnv
eval "$(direnv hook zsh)"

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/home/dln/.pyenv/shims:${PATH}"
export PYENV_SHELL=zsh
# command pyenv rehash 2>/dev/null   # this is slow
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "$(pyenv "sh-$command" "$@")"
    ;;
  *)
    command pyenv "$command" "$@"
    ;;
  esac
}


autoload -Uz compdef
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

## Nix
export PATH=$HOME/.nix-profile/bin:$PATH
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
export NIX_REMOTE=daemon

## eksctl
if [ ! -f "${fpath[1]}/_eksctl" ]; then
	command -v eksctl >/dev/null 2>&1 && eksctl completion zsh > "${fpath[1]}/_eksctl"
fi

## Kubernetes
if [ ! -f "${fpath[1]}/_kubectl" ]; then
  command -v kubectl >/dev/null 2>&1 && kubectl completion zsh > "${fpath[1]}/_kubectl"
fi
export PATH=$HOME/.krew/bin:$PATH
alias kubectl='grc kubectl'

## bazel
#if [ ! -f "${fpath[1]}/_bazel" ]; then
#  curl -sLo "${fpath[1]}/_bazel" https://raw.githubusercontent.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel
#fi

## git-branchless
if [ ! -f "${fpath[1]}/_git_branchless" ]; then
  curl -sLo "${fpath[1]}/_git_branchless" https://gist.githubusercontent.com/minijackson/68effb0e6c7d8333e20f07da20076c28/raw/5469ffa1c6adc245adb82316f1013937c5148da7/_git-branchless
fi

## go-task
if [ ! -f "${fpath[1]}/_task" ]; then
  curl -sLo "${fpath[1]}/_task" https://raw.githubusercontent.com/go-task/task/main/completion/zsh/_task
fi

## kapp
if [ ! -f "${fpath[1]}/_kapp" ]; then
	command -v kapp >/dev/null 2>&1 && kapp completion zsh --tty=false > "${fpath[1]}/_kapp"
fi

## kn
if [ ! -f "${fpath[1]}/_kn" ]; then
  command -v kn >/dev/null 2>&1 && kn completion zsh > "${fpath[1]}/_kn"
fi

## talos cli
if [ ! -f "${fpath[1]}/_talosctl" ]; then
	command -v talosctl >/dev/null 2>&1 && talosctl completion zsh > "${fpath[1]}/_talosctl"
fi

## pulumi
if [ ! -f "${fpath[1]}/_pulumi" ]; then
	command -v pulumi >/dev/null 2>&1 && pulumi gen-completion zsh > "${fpath[1]}/_pulumi"
fi

## vault
complete -o nospace -C /usr/bin/vault vault

## Google Cloud
[ -f /opt/google-cloud-sdk/completion.zsh.inc ] && source /opt/google-cloud-sdk/completion.zsh.inc
if [ -f '/home/dln/google-cloud-sdk/path.zsh.inc' ]; then . '/home/dln/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/home/dln/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/dln/google-cloud-sdk/completion.zsh.inc'; fi

## Golang
export PATH=$HOME/go/bin:$PATH
export GOPROXY=https://athens.aarn.shelman.io

## Ansible
export ANSIBLE_NOCOWS=1

## Docker
export DOCKER_BUILDKIT=1

PROG=tea _CLI_ZSH_AUTOCOMPLETE_HACK=1 source "/home/dln/.config/tea/autocomplete.zsh"

## AWS
complete -o nospace -C /usr/bin/mcli mcli
complete -C '/usr/bin/aws_completer' aws

function _grc() {
  shift words
  (( CURRENT-- ))
  _normal
}
compdef _grc grc

# Atuin history
eval "$(atuin init zsh --disable-up-arrow)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
