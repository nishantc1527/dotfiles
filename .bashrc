#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# This guy is good https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c. I copied lots of things from him.

neofetch | lolcat

. ~/.fancy-git/prompt.sh

for elem in {e,x,i,t}{e,x,i,t}{e,x,i,t}{e,x,i,t}
do alias $elem="exit"
done

for elem in {c,l,e,a,r}{c,l,e,a,r}{c,l,e,a,r}{c,l,e,a,r}{c,l,e,a,r}
do alias $elem="clear"
done

alias :q="exit"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../..'
alias .....='cd ../../..'
alias ......='cd ../../..'
alias .......='cd ../../../..'
alias ........='cd ../../../../..'

alias ls='ls -lA | lolcat'

alias sl='ls'
alias dc='cd'

alias cls="clear"

alias da='date "+%Y-%m-%d %A %T %Z" | lolcat'

alias commit='git commit'
alias push='git push'
alias add='git add .'
alias status='git status'
alias diff='git diff'
alias clone='git clone'
alias pull='git pull'
alias reset='git reset'
alias log="git log"
alias revert="git revert"
alias restore="git restore"

alias vim="nvim"

set -o vi

alias pip="pip3"

alias i=$'yes | sudo pacman -Sy $(pacman -Sl | awk \'{$1= ""; print $0}\' | grep -v installed | awk \'{print $1;}\' | sort | fzf -m --preview=\"pacman -Sii {}\")'
alias u=$'yes | sudo pacman -Rns $(pacman -Sl | awk \'{$1= ""; print $0}\' | grep installed | awk \'{print $1;}\' | sort | fzf -m --preview=\"pacman -Sii {}\")'
alias g="cd \$(~/dirs.py | fzf)"
alias gg="cd \$(~/home-dirs.py | fzf)"
alias v="vim \$(fzf)"

alias sync="timedatectl set-ntp true"

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

alias r="ranger"
alias n="nnn"

export NVIM_HOME="$HOME/.config/nvim"
export EDITOR="nvim"
export VISUAL="nvim"

alias gw="./gradlew"

alias rm="trash"
