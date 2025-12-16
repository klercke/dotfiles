# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Use GPG for SSH auth
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null

# Aliases
alias lg='lazygit'
alias ls='eza -lah --color=auto --icons'

# Environment config
export EDITOR=nvim
export SUDO_EDITOR=nvim

# Use zoxide as a cd replacement
eval "$(zoxide init zsh --cmd cd)"

# Make fastfetch show up in new terminals for maximum rice (but only if it's installed)
command -v fastfetch >/dev/null && fastfetch

# Starship prompt (keep this at the end)
eval "$(starship init zsh)"
