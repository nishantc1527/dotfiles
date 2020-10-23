#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

neofetch

. ~/.fancy-git/prompt.sh

for elem in {e,x,i,t}{e,x,i,t}{e,x,i,t}{e,x,i,t}
do alias $elem="exit"
done

for elem in {c,l,e,a,r}{c,l,e,a,r}{c,l,e,a,r}{c,l,e,a,r}{c,l,e,a,r}
do alias $elem="clear"
done

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
alias clone='gh repo clone'
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

alias vim="nvim"

set -o vi

alias pip="pip3"

alias i=$'yes | sudo pacman -Syu $(pacman -Sl | awk \'{$1= ""; print $0}\' | fzf --multi | awk \'{print $1;}\' | sort)'
alias u=$'yes | sudo pacman -Rns $(pacman -Sl | awk \'{$1= ""; print $0}\' | fzf --multi | awk \'{print $1;}\' | sort)'
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

alias vimb="vimb google.com"

alias cat="bat"

alias android="emulator -avd \"\$(emulator -list-avds)\""
