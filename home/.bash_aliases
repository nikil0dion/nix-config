### ALIASES ###

# K8s / Docker / Systemd
alias k='kubectl'
alias s='systemctl'
alias dc='docker compose'
alias d='docker'

# Systems 
alias df='df -hT'
alias dush='du -shm | sort -rh'
alias ls='lsd --color=auto'
alias la='lsd -a' # hidden files
alias lx='lsd -lXh' # sort by extension
alias lk='lsd -lSrh' # sort by size
alias lr='lsd -lRh' # recursive ls
alias lt='lsd -ltrh' # sort by date
alias cpr='cp -r'
alias mvr='mv -r'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias jctl="journalctl -p 3 -xb"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Network
alias sst='ss -tulpn'
alias lsf='lsof -i -P'
alias ping='ping -c 10'


