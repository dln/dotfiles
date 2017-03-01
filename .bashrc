export DOTFILES="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
export PATH=$DOTFILES/bin:$PATH


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"
export LESSCLOSE=''
export LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
#export LESSOPEN="|less-pygmentize %s"

export LESS_TERMCAP_mb=$'\E[01;34PS1_PREFIX="\u@\h:"m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# git
export GIT_PS1_SHOWDIRTYSTATE=1
if [ -f "$HOME/.bash_completion_git" ] ; then
    source ~/.bash_completion_git
fi

# Check for interactive shell.
if [ -n "$PS1" ]; then
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
unset bash bminor bmajor

# Bash settings
export IGNOREEOF=1
# bind '"\t":menu-complete'  # cycle completion
# set -o ignoreeof # don't exit on C-d
shopt -s cdspell  # spellcheck cd

shopt -s histappend  # Save history
PROMPT_COMMAND='history -a ; ${PROMPT_COMMAND}'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# acd_func 1.0.5, 10-nov-2004
# petar marinov, http:/geocities.com/h2428, this is public domain

cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

alias cd=cd_func

umask 2
stty speed 115200 >> /dev/null 2>&1

# Terminal setup
tput smkx


# OpenPGP applet support for YubiKey NEO
#if [ ! -f /tmp/gpg-agent.env ]; then
#    killall gpg-agent;
#    eval $(gpg-agent --daemon --enable-ssh-support > /tmp/gpg-agent.env);
#fi
#. /tmp/gpg-agent.env

source <(kubectl completion bash)

source $HOME/.bash_aliases
source $HOME/.bash_exports
source $HOME/.bash_prompt
source $HOME/.bash_completion
