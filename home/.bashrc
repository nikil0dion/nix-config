# ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

export ANDROID_HOME=$HOME/Android/Sdk
export SDKMANAGER_HOME=$HOME/Android/Sdk
export PATH=$PATH:/usr/local/bin:$HOME/.config/FlutterSDK/flutter/bin:$HOME/.local/go/bin:$HOME/yandex-cloud/bin
export DOCKER_HOST=unix:///var/run/docker.sock


# set history size
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command
shopt -s checkwinsize

# Load aliases if available
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

source <(kubectl completion bash)
complete -o default -F __start_kubectl k

# files 
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

# storages 
alias df='df -hT'
alias dush='du -smh * | sort -rh'
alias iosx='iostat -xtc --human 1'

# network
alias sst='ss -tulpn'

# go
alias g='go'
alias gr='go run'
alias gb='go build'
alias gt='go test'
alias gmi='go mod init'
alias gmt='go mod tidy'
alias gmd='go mod download'

# git
alias gs='git status'
alias gadd='git add .'
alias gpll='git pull'
alias gpsh='git push'
alias gcom='git commit -am'
alias gche='git checkout'
alias gcheb='git checkout -b'


# kubernetes
alias k='kubectl'
alias ksys='kubectl -n kube-system get all'
alias kg='kubectl get'
alias kgp='kubectl get pod'
alias kgd='kubectl get deployment'
alias kd='kubectl delete'
alias kgs='kubectl get service'

# docker compose 
alias dc='docker compose'
alias dcls='docker compose ls'
alias dcps='docker compose ps'
alias dcupd='docker compose up -d'

# docker
alias d='docker'
alias dl='docker logs'
alias dlf='docker logs -f'
alias de='docker exec'
alias deit='docker exec -it'
alias ds='docker stop'
alias drm='docker rm'
alias dps='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" | sed -E "s/(Up[^ ]*)/\x1b[32m\1\x1b[0m/; s/(Exited[^ ]*|Down|Dead)/\x1b[31m\1\x1b[0m/; s/(Restarting[^ ]*)/\x1b[33m\1\x1b[0m/"'

# system 
alias s='systemctl'
alias sys='sysctl'
alias e='exit'
alias j='journalctl'
alias jf='journalctl -f'


# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

buffer_clean(){
  free -h && sudo sh -c 'echo 1 >  /proc/sys/vm/drop_caches' && free -h
}


# The next line updates PATH for CLI.
if [ -f '/$HOME/yandex-cloud/path.bash.inc' ]; then source '/$HOME/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/$HOME/yandex-cloud/completion.bash.inc' ]; then source '/$HOME/yandex-cloud/completion.bash.inc'; fi
