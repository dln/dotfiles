
set fish_greeting

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/bin

## Nix
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
export NIX_REMOTE=daemon
fish_add_path $HOME/.nix-profile/bin

if status is-interactive

    ## Pager
    export LESS="--mouse --wheel-lines=1 -nRXF"
    export LESSCOLORIZER="bat"
    export LESSOPEN="|lesspipe.sh %s"
    export PAGER="bat"
    export BAT_PAGER="less -r"

    ## OpenTelemetry
    export OTEL_EXPORTER_OTLP_ENDPOINT=https://otel.aarn.shelman.io
    export OTEL_RESOURCE_ATTRIBUTES=instance=dln-dev
    export OTEL_LOG_LEVEL=debug

    ## Utilities

    export EDITOR=nvim

    function tree
        eza --tree --color=always $argv | bat --wrap=never
    end

    function rg --wraps rg --description 'ripgrep with bat'
        /usr/bin/rg --color=always $argv | bat --wrap=never
    end

    ## Directory jumping with frecency 

    function fre_after_cd --on-variable PWD
        fre --add "$PWD"
    end

    function jump
        set _dir $(fre --sorted | fzf-tmux --no-sort -p 90%,40% -y 0 -- --color=fg:248,bg+:16,fg+:49,pointer:49,border:49 --layout=reverse)
        [ -n "$_dir" ] && pushd $_dir >>/dev/null
        commandline -f repaint
    end
    bind \cg jump

    ## Kubernetes
    fish_add_path $HOME/.krew/bin
    # function kubectl --wraps kubectl
    #     command kubecolor $argv
    # end

    ## History

    # FIXME: how to use autin history for these?
    bind \cn history-prefix-search-forward
    bind \cp history-prefix-search-backward

    atuin init fish | source
end

## Direnv
direnv hook fish | source
