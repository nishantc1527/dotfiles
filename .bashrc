#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

neofetch

. ~/.fancy-git/prompt.sh
. ~/.git-completion.bash

for elem in {e,x,i,t}{e,x,i,t}{e,x,i,t}{e,x,i,t}
do alias $elem="exit"
done

for elem in {c,l,s}{c,l,s}{c,l,s}
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
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit'
alias diff='git diff'
alias log="git log --oneline --all"
alias pull='git pull'
alias push='git push'
alias reset='git reset'
alias restore="git restore"
alias revert="git revert"
alias show='git show'
alias status='git status'
alias switch='git switch'
alias worktree='git worktree'

alias tree="tree -C"

alias vi="nvim"
alias vim="nvim"

set -o vi

alias pip="pip3"
alias find="fd"

alias i=$'yes | sudo pacman -Syu $(pacman -Sl | awk \'{$1= ""; print $0}\' | fzf --multi --preview \'pacman -Si {1}\' | awk \'{print $1;}\' | sort)'
alias u=$'yes | sudo pacman -Rns $(pacman -Sl | awk \'{$1= ""; print $0}\' | fzf --multi --preview \'pacman -Si {1}\' | awk \'{print $1;}\' | sort)'
alias c=$'git reset --hard $(git log --oneline --all | fzf --preview=\'git show {1} --color\' | awk \'{print $1;}\')'
alias h="\$(history | awk '{\$1 = \"\"; print \$0}' | fzf)"
alias x="\$(compgen -c | sort -u | fzf)"
alias g="cd \$(~/dirs.py | fzf)"
alias gg="cd \$(~/home-dirs.py | fzf)"
alias v="vim \$(fd --hidden | fzf)"

alias sync="timedatectl set-ntp true"

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

alias r="ranger"
alias n="nnn"

export EDITOR="nvim"
export VISUAL="nvim"

alias gw="./gradlew"

alias vimb="vimb google.com"
alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
alias android="emulator -avd \"\$(emulator -list-avds)\""
alias shut="shutdown -h now"
alias google-chrome="google-chrome-stable"
alias mysql="mysql -u root -p"

alias grep="grep --color=auto"
alias ip='ip -color=auto'

alias get="go get"

alias qemu="qemu-system-x86_64"

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
