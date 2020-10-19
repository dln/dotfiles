source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-history-substring-search', defer:3
# zplug 'zsh-users/zsh-autosuggestions'
# zplug 'Aloxaf/fzf-tab'

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


## zsh settings
setopt pipe_fail
setopt auto_pushd
setopt no_beep
setopt no_rm_star_silent
setopt extended_glob
setopt ksh_glob
setopt null_glob

## Completion
autoload -Uz compinit
compinit

## Autosuggest
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#D7CCC8,italic"
# ZSH_AUTOSUGGEST_USE_ASYNC=1
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)

## fasd
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

eval "$(fasd --init posix-alias zsh-hook)"

cd_func () {
  local dir
  if [[ $1 ==  "--" ]]; then
    _jump || return 1
    return 0
  elif [[ -z "$1" ]]; then
    dir="$HOME"
  else
    dir="$@"
  fi
  "cd" "${dir}"
  fasd -A $PWD
}
alias cd=cd_func

redraw-prompt() {
    local precmd
    for precmd in $precmd_functions; do
        $precmd
    done
    zle reset-prompt
}
zle -N redraw-prompt

_jump() {
  dir="$(fasd -Rdlt | fzf --tiebreak=end -1 -0 --no-sort +m --height 10)" && cd_func "${dir}"
  zle && zle redraw-prompt
}

zle -N _jump

## Keybindings
bindkey -e
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^g' _jump


## Gnupg  / gpg / ssh / yubikey
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)


## Pager
export LESS="--mouse --wheel-lines=1 -nRX"

## Aliases
alias cdiff='colordiff -u'
alias dotgit='git --work-tree $HOME --git-dir $HOME/.dot_git'
alias l=bat
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

## fzf
export FZF_TMUX=1
export FZF_COMPLETION_TRIGGER=";"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
. /usr/share/fzf/completion.zsh
. /usr/share/fzf/key-bindings.zsh

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

function _precmd(){
  tmux set -w @starship "$(env STARSHIP_CONFIG=$HOME/.config/starship-tmux.toml starship prompt -s ${STATUS:-0} -j ${NUM_JOBS:-0} -d ${STARSHIP_DURATION:-0})"
}
starship_precmd_user_func="_precmd"
precmd_functions+=(_precmd)

export PATH=$HOME/bin:$PATH

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/vault vault
