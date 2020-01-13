#peco
function fish_user_key_bindings
    bind \cr peco_select_history
end
status --is-interactive; and source (anyenv init -|psub)

