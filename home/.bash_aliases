### ALIASES ###

# Files 
alias ls='lsd --color=auto'
alias la='lsd -a'
alias lx='lsd -lXh' # sort by extension
alias lk='lsd -lSrh' # sort by size
alias lr='lsd -lRh' # recursive ls
alias lt='lsd -ltrh' # sort by date
alias lm='lsd -alh | more' # pipe through 'more'
alias ll='lsd -alFh' # long listing format
alias lf="lsd -l | grep -E -v '^d'" # files only
alias ldir="lsd -l | grep -E '^d' --color=never" # directories only
alias l='lsd'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias nano='nano -l'
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

# Storages 
alias df='df -hT'
alias dush='du -smh * | sort -rh'

# Kubernetes & Docker
alias k='kubectl'
alias ksys='kubectl -n kube-system get all'
alias kg='kubectl get'
alias kgp='kubectl get pod'
alias kgd='kubectl get deployment'
alias kd='kubectl delete'
alias kgs='kubectl get service'
alias dc='docker compose'
alias d='docker'

# System 
alias s='systemctl'
alias e='exit'
alias j='journalctl'

# Network
alias sst='ss -tulpn'
alias lsf='lsof -i -P'
alias ping='ping -c 10'


