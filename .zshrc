# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  # export ZSH=/home/dln/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
export PATH=$HOME/bin:$PATH:/bin:/sbin:/usr/sbin:/usr/local/sbin

ZSH_THEME="robbyrussell"

export DIRENV_LOG_FORMAT= 
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

export HISTFILE=~/.zsh_history
export SAVEHIST=9000
export LPASS_AGENT_TIMEOUT=900

typeset -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_HIGHLIGHT_STYLES[command]='fg=155'
export ZSH_HIGHLIGHT_STYLES[builtin]='fg=190'

setopt append_history
setopt share_history

source ~/.zplug/init.zsh

zplug "miekg/lean"
zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/history-substring-search", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "~/.zsh", from:local

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git git-extras history-substring-search vault)
#
# source $ZSH/oh-my-zsh.sh
# source ~/.oh-my-zsh/plugins/zsh-titles/titles.plugin.zsh

function short_pwd {
  echo $PWD | sed "s:${HOME}:~:" | sed "s:/\(.\)[^/]*:/\1:g" | sed "s:/[^/]*$:/$(basename $PWD):"
}

function _dln_prompt_left {
  _pw="$(short_pwd)"
  echo -e "%{\e[38;5;246m%}$_pw "
}

function _dln_prompt_right {
  _tmux_win=`tmux display-message -p "#I" 2>/dev/null`
  echo -e " %{\e[38;5;16;48;5;30m%} ${_tmux_win} %{\e[0m%}"
}

export PROMPT_LEAN_COLOR1=78
export PROMPT_LEAN_COLOR2=67
export PROMPT_LEAN_TMUX=" "
export PROMPT_LEAN_PATH_PERCENT=50
export PROMPT_LEAN_LEFT=_dln_prompt_left
# export PROMPT_LEAN_RIGHT=_dln_prompt_right


function prompt_command {
  banner="$USER@$HOST"
  ((prompt_x = $(tput cols) - $(expr length ${banner}) - 3))
  tput sc
  tput cup 0 ${prompt_x}
  if [ "$USER" = "root" ]; then
    echo -ne " \e[38;5;228;48;5;160m ${banner} \e[0m"
  else
    echo -ne " \e[38;5;195;48;5;33m ${banner} \e[0m"
  fi
  tput rc
  #tmux rename-window `basename $PWD`
  tmux rename-window $(short_pwd) 2>/dev/null
  eval $(tmux switch-client \; show-environment -s 2>/dev/null)
}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ls='ls --color=auto --group-directories-first --human-readable --almost-all'

bindkey -e
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M emacs '^P' history-beginning-search-backward
bindkey -M emacs '^N' history-beginning-search-forward

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
  eval $(direnv export zsh)
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
  dir="$(fasd -Rdl | fzf -1 -0 --no-sort +m --height 10)" && cd_func "${dir}"
  zle && zle redraw-prompt
}

zle -N _jump
bindkey '^g' _jump

## vim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

e ()
{
  tmux select-window -t1 
  nvr --remote $(readlink -f "$@")
}

## Powerline
# . /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

## fzf
export FZF_TMUX=1
export FZF_COMPLETION_TRIGGER=";"
. /usr/share/fzf/completion.zsh
. /usr/share/fzf/key-bindings.zsh

# Kubernetes
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)
command -v kops    >/dev/null 2>&1 && source <(kops completion zsh)
command -v helm    >/dev/null 2>&1 && source <(helm completion zsh)

[ -f /usr/share/bash-completion/completions/aws ] && source /usr/share/bash-completion/completions/aws
[ -f /opt/google-cloud-sdk/completion.zsh.inc ] && source /opt/google-cloud-sdk/completion.zsh.inc

# Pager
command -v pygmentize >/dev/null 2>&1 && export LESSOPEN="|/usr/bin/pygmentize -f terminal16m -O style=native %s"

## Aliases
alias ag='ag --pager less'
alias cdiff='colordiff -u'
alias dotgit='git --work-tree $HOME --git-dir $HOME/.dot_git'
alias hs='history -a; history -n'
alias l='less -nS'
alias lower="tr '[:upper:]' '[:lower:]'"
alias pstree="pstree -Auh | less"
alias tail='tail -n $LINES'
alias timestamp='TZ=Z date "+%Y%m%dT%H%M%SZ"'
alias tree='tree -C'
alias upper="tr '[:lower:]' '[:upper:]'"
alias vimdiff='vimdiff -R'
alias vim=nvim
alias xc='xclip -selection clipboard'
# alias e='nvr --remote'



