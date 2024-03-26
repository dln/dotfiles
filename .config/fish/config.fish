
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

    ## Utilities

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
        set _dir $(fre --sorted | fzf-tmux --no-sort -p 90%,40% -y 0)
        [ -n "$_dir" ] && pushd $_dir >>/dev/null
        commandline -f repaint
    end
    bind \cg jump

    ## Kubernetes
    fish_add_path $HOME/.krew/bin
    alias kubectl=kubecolor

    ## History

    atuin init fish | source
end

## Direnv
direnv hook fish | source
