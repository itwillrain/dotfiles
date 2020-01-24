#peco
function fish_user_key_bindings
  bind \cr peco_select_history	
  bind \c] peco_change_directory # Bind for prco change directory to Ctrl+]
end
status --is-interactive; and source (anyenv init -|psub)


