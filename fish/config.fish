#peco
function fish_user_key_bindings
    bind \cr peco_select_history
end
set -x PATH $HOME/.anyenv/bin $PATH
status --is-interactive; and source (anyenv init -|psub)
