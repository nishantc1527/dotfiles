# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

test -s ~/.alias && . ~/.alias || true

# This guy is good https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c. I copied lots of things from him.

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

alias rm='rm -rf'

alias ls='ls -lAFh --color=always' # add colors and file type extensions
alias sl='ls'

alias cls="clear"

alias da='date "+%Y-%m-%d %A %T %Z"'

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

alias vim="nvim"

# Git branch in prompt.

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

export PATH="/home/nchatterjee/nvim-linux64/bin:$PATH"

set -o vi

alias pip="pip3"

alias i="sudo yum install -y \$(iword.py \$(yum list available) | fzf -m --preview='yum info {}')"
alias u="sudo yum remove -y \$(uword.py \$(yum list installed) | fzf -m --preview='yum info {}')"
alias g="cd \$(dirs.py | fzf)"
alias v="vim \$(fzf)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
