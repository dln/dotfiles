
function __jj_in_repo
    jj --ignore-working-copy --quiet root >>/dev/null 2>&1
end

function vcs_root
    jj workspace root --ignore-working-copy 2>/dev/null || git rev-parse --show-toplevel 2>/dev/null || pwd
end

function vcs_broot
    br (vcs_root)
    commandline -f repaint
end

function vcs_jump
    set _dir (vcs_root)
    if [ "$_dir" = "$PWD" ]
        set _dir (br -f --conf "$HOME/.config/broot/conf.toml")
    end
    [ -n "$_dir" ] && pushd $_dir >>/dev/null
    commandline -f repaint
end

function vcs_status
    if __jj_in_repo
        jj status --ignore-working-copy
    else
        git status -sb
    end
    commandline -f repaint
end

function vcs_diff
    if __jj_in_repo
        jj show $argv
    else
        git diff --stat -p -C --color-words $argv
    end
    commandline -f repaint
end


function vcs_log
    if __jj_in_repo
        jj log --ignore-working-copy $argv
    else
        git diff --stat -p -C --color-words $argv
    end
    commandline -f repaint
end

function vcs_ui
    if __jj_in_repo
        lazyjj
    else
        gitui
    end
    commandline -f repaint
end

# Abbreviations

abbr -a d vcs_diff
abbr -a s vcs_status

# Bindings
bind \c_ vcs_jump
bind \ea vcs_log
bind \ee vcs_broot
bind \eg vcs_ui
bind \eS vcs_diff
bind \es vcs_status
