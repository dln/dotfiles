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
zi ice wait lucid
zi load zsh-users/zsh-syntax-highlighting
zi ice wait lucid
zi load zsh-users/zsh-history-substring-search

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


## zsh settings
setopt pipe_fail
setopt auto_pushd
setopt no_beep
setopt no_rm_star_silent
setopt extended_glob
setopt ksh_glob
setopt null_glob

## Autosuggest
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#D7CCC8,italic"
# ZSH_AUTOSUGGEST_USE_ASYNC=1
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export PATH=$HOME/bin:$PATH

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
  _gitroot=$(git rev-parse --show-toplevel 2>/dev/null || sl root 2>/dev/null || pwd)
  _dir=$((echo "$_gitroot" && fd -td . "$_gitroot") | fzf-tmux -p 90%,40% -y 0)
  [ -n "$_dir" ] && cd $_dir
  zle && zle redraw-prompt
}
zle -N _cwd_gitroot

## Keybindings
bindkey -e
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^g' _jump
bindkey '^_' _cwd_gitroot


## Gnupg  / gpg / ssh / yubikey
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)


## Pager
export LESS="--mouse --wheel-lines=1 -nRXF"

## Clipboard OSC 52
 function clip { echo -en "\x1b]52;c;$(base64 -w0)\x07" }

## Aliases
alias c='cut -c-${COLUMNS}'
alias e='wezterm-edit-helper'
alias dotgit='git --work-tree $HOME --git-dir $HOME/.dot_git'
alias l=bat
alias lw='bat --wrap=never'
alias ls=exa
alias tail='tail -n $LINES'
alias timestamp='TZ=Z date "+%Y%m%dT%H%M%SZ"'
alias tree='exa --tree'
alias v=vgrep
alias ve='env EDITOR= vgrep -s'
alias xc=clip
alias w="history -1 | sed -e 's/[0-9]*  //' | xargs viddy -n1"

## ripgrep 
export RIPGREP_CONFIG_PATH=${HOME}/.config/shelman-theme/current/rg/rg.conf

# "auto paging"
rg() {
  /usr/bin/rg -p "$@" | bat
}

fix_cursor() {
  echo -ne '\e[5 q'
}

precmd_functions+=(fix_cursor)


## Prompt
eval "$(starship init zsh)"

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

## eksctl
if [ ! -f "${fpath[1]}/_eksctl" ]; then
	command -v eksctl >/dev/null 2>&1 && eksctl completion zsh > "${fpath[1]}/_eksctl"
fi

## Kubernetes
if [ ! -f "${fpath[1]}/_kubectl" ]; then
  command -v kubectl >/dev/null 2>&1 && kubectl completion zsh > "${fpath[1]}/_kubectl"
fi
export PATH=$HOME/.krew/bin:$PATH

## bazel
if [ ! -f "${fpath[1]}/_bazel" ]; then
  curl -sLo "${fpath[1]}/_bazel" https://raw.githubusercontent.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel
fi

## sapling
if [ ! -f "${fpath[1]}/_sl" ]; then
  # See: https://github.com/facebook/sapling/pull/369
  curl -sLo "${fpath[1]}/_sl" https://github.com/facebook/sapling/raw/d6157db1ebc0868cf70805756e32541bd681bac2/eden/scm/contrib/zsh_completion_sl
fi

## Tekton cli
if [ ! -f "${fpath[1]}/_tkn" ]; then
	command -v tkn >/dev/null 2>&1 && tkn completion zsh > "${fpath[1]}/_tkn"
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

## Google Cloud
[ -f /opt/google-cloud-sdk/completion.zsh.inc ] && source /opt/google-cloud-sdk/completion.zsh.inc

## Golang
export PATH=$HOME/go/bin:$PATH
GOPROXY=https://athens.aarn.shelman.io

## Ansible
export ANSIBLE_NOCOWS=1

## Docker
export DOCKER_BUILDKIT=1

autoload -Uz compinit
compinit

autoload -Uz compdef

PROG=tea _CLI_ZSH_AUTOCOMPLETE_HACK=1 source "/home/dln/.config/tea/autocomplete.zsh"

## AWS
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/mcli mcli
complete -C '/usr/bin/aws_completer' aws


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dln/google-cloud-sdk/path.zsh.inc' ]; then . '/home/dln/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dln/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/dln/google-cloud-sdk/completion.zsh.inc'; fi
