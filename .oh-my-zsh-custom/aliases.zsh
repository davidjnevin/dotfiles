#Aliases

# Git Aliases
alias gitac='git add . && git commit'
alias gs='git status'
alias gss='git status -s'

# Python Aliases
alias pvenv='python3.10 -m venv venv && source venv/bin/activate'
alias ae="source venv/bin/activate"
alias de=deactivate

# General Linux Aliases
alias c=clear
alias ll='ls -al'
alias lt='ls -lrth'
#alias cat=rich
alias e='exit'
alias la="pls -a"
alias pip=pip3
alias py=python3
alias python=python3

# Silver searcher
alias agg="ag --python"

# zshrc and vimrc
alias sz="exec zsh"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"

# Django Aliases
alias prs="poetry run python manage.py runserver"
alias rs="python manage.py runserver"
alias prsp="poetry run python manage.py runserver_plus --cert-file cert.crt"

# PythonAlicante Makeintegrations Aliases
fixmigrations(){
isort ./meetupselector/proposals/migrations/ ./meetupselector/user/migrations ./meetupselector/talks/migrations
black ./meetupselector/proposals/migrations/ ./meetupselector/user/migrations/ ./meetupselector/talks/migrations
}

# Dotfiles Management
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
