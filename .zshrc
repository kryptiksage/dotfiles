# Auto
autoload -U compinit; compinit
setopt autocd autopushd
zstyle ':completion:*' menu select
zmodload zsh/complist

# History
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# Powerlevel10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Alias
alias ls="ls -a --color=auto"
alias ...="cd ../.."
alias rank-mirrors="sudo reflector --latest 50 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist --verbose && sudo pacman -Syy"
alias wifi="nmcli device wifi connect"
alias poweroff="poweroff 2> /dev/null || sudo systemctl poweroff"

# vi mode
bindkey -v

# Delete Key Fix
bindkey -v "^[[P" delete-char
