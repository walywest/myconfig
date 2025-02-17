# Created by newuser for 5.9
eval "$(zoxide init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

alias nls="ls"
alias x="exit"
alias cat="bat"
alias fman="compgen -c | fzf | xargs man"
alias nv="nvim ."
alias n="neovide ."
alias ls="eza --long --header --icons --git"
alias nz="/home/dumbledoor/scripts/zoxide_nvim.sh"
# alias update="sudo /home/dumbledoor/scripts/nixos-rebuild.sh"
alias update="sudo nixos-rebuild switch"
alias conf="sudo nvim /etc/nixos/configuration.nix"

alias hc_rebuild="sudo nix-collect-garbage; sudo nix-collect-garbage -d; sudo nixos-rebuild switch"
alias hc="sudo nix-collect-garbage; sudo nix-collect-garbage -d"
alias clean_store="sudo nix-store --gc --print-dead"
alias ghostty="ghostty --gtk-titlebar=false"
alias habat="/home/dumbledoor/scripts/habat.sh"




# # export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
# export FZF_DEFAULT_COMMAND="fd"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
#
# export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
#
# # Setup fzf previews
# export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
# export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
#
# # fzf preview for tmux
# export FZF_TMUX_OPTS=" -p90%,70% "  
