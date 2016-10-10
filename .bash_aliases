alias ag='ag --pager less'
alias cdiff='colordiff -u'
alias dotgit='git --work-tree $HOME --git-dir $HOME/.dot_git'
alias hs='history -a; history -n'
alias l='less -n'
alias lower="tr '[:upper:]' '[:lower:]'"
alias pstree="pstree -Auh | less"
alias tail='tail -n $LINES'
alias timestamp='TZ=Z date "+%Y%m%dT%H%M%SZ"'
alias tree='tree -C'
alias upper="tr '[:lower:]' '[:upper:]'"
alias vimdiff='vimdiff -R'
alias vim='vim -X'

ls --group-directories-first >/dev/null 2>&1
if [ $? -gt 0 ] ; then
    alias ls='ls --color=auto'
else
    alias ls='ls --color=auto --group-directories-first'
fi
alias lsc='ls -C'

# vim: ft=sh
