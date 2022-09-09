source ~/.zplug/init.zsh

source /etc/profile.d/locale.sh

zplug "zsh-users/zsh-completions"
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-history-substring-search', defer:3

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

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
  _gitroot=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
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
alias e='tmux-edit-helper'
alias dotgit='git --work-tree $HOME --git-dir $HOME/.dot_git'
alias l=bat
alias ls=exa
alias tail='tail -n $LINES'
alias timestamp='TZ=Z date "+%Y%m%dT%H%M%SZ"'
alias tree='exa --tree'
alias v=vgrep
alias ve='env EDITOR= vgrep -s'
alias xc=clip
alias w="history -1 | sed -e 's/[0-9]*  //' | xargs viddy -n1"

## ripgrep 
export RIPGREP_CONFIG_PATH=${HOME}/.config/rg/rg.conf

# "auto paging"
rg() {
  /usr/bin/rg -p "$@" | bat
}


## Prompt
eval "$(starship init zsh)"

function _title(){
  printf '%-16.16s' "$(starship module directory | sed 's/\x1b\[[0-9;]*m//g')"
}

function set_win_title(){
    echo -ne "\033]0; $(_title) \007"
}
set_win_title

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
eval "$(pyenv init -)"

## eksctl
if [ ! -f "${fpath[1]}/_eksctl" ]; then
	command -v eksctl >/dev/null 2>&1 && eksctl completion zsh > "${fpath[1]}/_eksctl"
fi

## Kubernetes
command -v kubectl >/dev/null 2>&1 && kubectl completion zsh > "${fpath[1]}/_kubectl"
export PATH=$HOME/.krew/bin:$PATH

## bazel
if [ ! -f "${fpath[1]}/_bazel" ]; then
  curl -sLo "${fpath[1]}/_bazel" https://raw.githubusercontent.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel
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

# hack until gcloud works with python 3.9
export CLOUDSDK_PYTHON=python2

## Golang
export PATH=$HOME/go/bin:$PATH
GOPROXY=https://athens.aarn.shelman.io

## Ansible
export ANSIBLE_NOCOWS=1

## Docker
export DOCKER_BUILDKIT=1


## PostgreSQL Operator
export PATH=/home/dln/.pgo/pgo:$PATH
export PGOUSER=/home/dln/.pgo/pgo/pgouser
export PGO_CA_CERT=/home/dln/.pgo/pgo/client.crt
export PGO_CLIENT_CERT=/home/dln/.pgo/pgo/client.crt
export PGO_CLIENT_KEY=/home/dln/.pgo/pgo/client.key
export PGO_APISERVER_URL='https://127.0.0.1:8443'
export PGO_NAMESPACE=pgo


# ## Completion
autoload -Uz compinit
compinit -i

## AWS
if [ -x /usr/bin/aws_zsh_completer.sh ]; then
	source /usr/bin/aws_zsh_completer.sh
fi


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dln/google-cloud-sdk/path.zsh.inc' ]; then . '/home/dln/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dln/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/dln/google-cloud-sdk/completion.zsh.inc'; fi
PROG=tea _CLI_ZSH_AUTOCOMPLETE_HACK=1 source "/home/dln/.config/tea/autocomplete.zsh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/mcli mcli
