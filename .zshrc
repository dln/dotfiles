source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load


## Completion
autoload -Uz compinit
compinit

## Gnupg  / gpg / ssh / yubikey
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)


## Pager
export LESS="--mouse --wheel-lines=1 -nRX"

## Aliases
alias cdiff='colordiff -u'
alias dotgit='git --work-tree $HOME --git-dir $HOME/.dot_git'
alias l='less -nRX'
alias ls=exa
alias tail='tail -n $LINES'
alias timestamp='TZ=Z date "+%Y%m%dT%H%M%SZ"'
alias tree='exa --tree'
alias xc='xclip -selection clipboard'

## vim
export EDITOR=nvim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

e ()
{
  tmux select-window -t1
  nvr --remote $(readlink -f "$@")
}

## direnv
eval "$(direnv hook zsh)"

## Kubernetes
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)
export PATH=$HOME/.krew/bin:$PATH

## Flux
export FLUX_FORWARD_NAMESPACE=flux

## Google Cloud
[ -f /opt/google-cloud-sdk/completion.zsh.inc ] && source /opt/google-cloud-sdk/completion.zsh.inc

## Golang
export PATH=$HOME/go/bin:$PATH
GOPROXY=https://proxy.golang.org/

## Ansible
export ANSIBLE_NOCOWS=1

## Prompt
eval "$(starship init zsh)"

export PATH=$HOME/bin:$PATH


