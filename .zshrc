# Set up zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Install zinit plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit
zinit cdreplay -q

# Completion Settings
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no

# Keybinds
bindkey -v # Vim mode
export KEYTIMEOUT=1
bindkey '^j' history-search-forward
bindkey '^k' history-search-backward

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Use GPG for SSH auth
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null

# General aliases
alias lg='lazygit'
alias ls='eza -lah --color=auto --icons'
alias cat=bat
alias find=fd

# OpenTofu aliases
alias tf='tofu' # All other aliases will use this so that the base OpenTofu command can be overridden
alias tfa='tf apply'
alias tff='tf fmt'
alias tffr='tf fmt -recursive'
alias tfi='tf init'
alias tfp='tf plan'
alias tfv='tf validate'
alias tfo='tf output'
alias tfs='tf state'
alias tfsh='tf show'
alias tfr='tf refresh'
alias tft='tf test'
alias tfws='tf workspace'

# Shell integrations
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color --icons $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color --icons $realpath'

# Environment config
export EDITOR={{editor}}
export SUDO_EDITOR={{editor}}

# Use zoxide as a cd replacement
eval "$(zoxide init zsh --cmd cd)"

# Make fastfetch show up in new terminals for maximum rice (but only if it's installed)
command -v fastfetch >/dev/null && fastfetch

# Starship prompt (keep this at the end)
eval "$(starship init zsh)"

# Put /usr/local/bin/ at start of path
# This is done so that uutils-coretils (which are symlinked there) are used over gnu coreutils
export PATH=/usr/local/bin:$PATH
