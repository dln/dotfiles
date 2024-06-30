set fish_greeting
set fish_emoji_width 2

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/bin

if status is-interactive

    ## Pager
    set -gx LESS "--mouse --wheel-lines=1 -nRXF"
    set -gx LESSCOLORIZER bat
    set -gx LESSOPEN "|lesspipe.sh %s"
    set -gx PAGER bat
    set -gx BAT_PAGER "less -r"

    ## OpenTelemetry
    set -gx OTEL_EXPORTER_OTLP_ENDPOINT https://otel.aarn.shelman.io
    set -gx OTEL_RESOURCE_ATTRIBUTES instance=dln-dev
    set -gx OTEL_LOG_LEVEL debug

    ## Utilities

    set -gx EDITOR (which nvim)
    set -gx VISUAL $EDITOR
    set -gx SUDO_EDITOR $EDITOR

    function tree
        eza --tree --color=always $argv | bat --wrap=never
    end

<<<<<<< HEAD
    ## Directory jumping with frecency 

    function fre_after_cd --on-variable PWD
        fre --add "$PWD"
    end

    function jump
        set _dir $(fre --sorted | fzf --no-sort --border=rounded --layout=reverse '--bind=ctrl-g:become(br -f --conf ~/.config/broot/select.hjson $(git rev-parse --show-toplevel 2>/dev/null || pwd))')
        [ -n "$_dir" ] && pushd $_dir >>/dev/null
        commandline -f repaint
    end
    bind \cg jump
||||||| parent of 931ae14 (fish: use zoxide instead of fre + fzf)
    function rg --wraps rg --description 'ripgrep with bat'
        /usr/bin/rg --color=always $argv | bat --wrap=never
    end

    ## Directory jumping with frecency 

    function fre_after_cd --on-variable PWD
        fre --add "$PWD"
    end

    function jump
        set _dir $(fre --sorted | fzf --no-sort --border=rounded --layout=reverse '--bind=ctrl-g:become(br -f --conf ~/.config/broot/select.hjson $(git rev-parse --show-toplevel 2>/dev/null || pwd))')
        [ -n "$_dir" ] && pushd $_dir >>/dev/null
        commandline -f repaint
    end
    bind \cg jump
=======
    function rg --wraps rg --description 'ripgrep with bat'
        /usr/bin/rg --color=always $argv | bat --wrap=never
    end

    bind \cg __zoxide_zi
>>>>>>> 931ae14 (fish: use zoxide instead of fre + fzf)

    function git_jump
        set _dir $(git rev-parse --show-toplevel 2>/dev/null || pwd)
        if [ "$_dir" = "$PWD" ]
            #set _dir $(br -f --conf ~/.config/broot/select.hjson)
            set _dir $(br -f --conf "$HOME/.config/broot/conf.hjson")
        end
        [ -n "$_dir" ] && pushd $_dir >>/dev/null
        commandline -f repaint
    end
    bind \c_ git_jump

    function git_broot
        br $(git rev-parse --show-toplevel 2>/dev/null || pwd)
        commandline -f repaint
    end

    bind \ee git_broot
    bind \eg gitui


    ## Kubernetes
    fish_add_path $HOME/.krew/bin
    # function kubectl --wraps kubectl
    #     command kubecolor $argv
    # end

    ## History

    # FIXME: how to use autin history for these?
    bind \cn history-prefix-search-forward
    bind \cp history-prefix-search-backward
    # bind \cP _atuin_bind_up
    bind \cJ forward-char

    atuin init fish | source
end

## Direnv
direnv hook fish | source
