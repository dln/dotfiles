
set fish_greeting

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/bin


if status is-interactive

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


    ## History

    atuin init fish | source


    ## Prompt

    function starship_transient_prompt_func
        starship module character
    end
    starship init fish | source
    enable_transience
end

## Direnv
direnv hook fish | source
