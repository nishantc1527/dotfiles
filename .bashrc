#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

neofetch

. ~/.fancy-git/prompt.sh

for elem in {e,x,i,t}{e,x,i,t}{e,x,i,t}{e,x,i,t}
do alias $elem="exit"
done

for elem in {c,l,e,a,r}{c,l,e,a,r}{c,l,e,a,r}{c,l,e,a,r}{c,l,e,a,r}
do alias $elem="clear"
done

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../..'
alias .....='cd ../../..'
alias ......='cd ../../..'
alias .......='cd ../../../..'
alias ........='cd ../../../..'

alias ls='ls -lA --color=always'

alias sl='ls'
alias dc='cd'

alias cls="clear"

alias add='git add .'
alias branch='git branch'
alias clone='git clone'
alias commit='git commit'
alias diff='git diff'
alias log="git log"
alias pull='git pull'
alias push='git push'
alias reset='git reset'
alias restore="git restore"
alias revert="git revert"
alias status='git status'
alias show='git show'

alias tree="tree -C"

alias vi="nvim"
alias vim="nvim"

set -o vi

alias pip="pip3"

alias i=$'yes | sudo pacman -Syu $(pacman -Sl | awk \'{$1= ""; print $0}\' | fzf --multi --preview \'pacman -Si {1}\' | awk \'{print $1;}\' | sort)'
alias u=$'yes | sudo pacman -Rns $(pacman -Sl | awk \'{$1= ""; print $0}\' | fzf --multi --preview \'pacman -Si {1}\' | awk \'{print $1;}\' | sort)'
alias h="\$(history | awk '{\$1 = \"\"; print \$0}' | fzf)"
alias x="\$(compgen -c | sort -u | fzf)"
alias g="cd \$(~/dirs.py | fzf)"
alias gg="cd \$(~/home-dirs.py | fzf)"
alias v="vim \$(fzf)"

alias sync="timedatectl set-ntp true"

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

alias r="ranger"
alias n="nnn"

export EDITOR="nvim"
export VISUAL="nvim"

alias gw="./gradlew"
alias run="./gradlew run"
alias brun="./gradlew bootRun"
alias build="./gradlew build"

alias vimb="vimb google.com"
alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
alias android="emulator -avd \"\$(emulator -list-avds)\""
alias shut="shutdown -h now"
alias google-chrome="google-chrome-stable"
alias mysql="mysql -u root -p"

alias grep="grep --color=auto"
alias ip='ip -color=auto'

alias get="go get"
