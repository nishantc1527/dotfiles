test -s ~/.alias && . ~/.alias || true

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

# Alias's for multiple directory listing commands
alias la='ls -lAlh' # show hidden files
alias ls='ls -laFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -lalh |more' # pipe through 'more'
alias lw='ls -lxAh' # wide listing format
alias ll='ls -lFls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

alias sourceb="source .bashrc"
