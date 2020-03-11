# Todolist
alias copr="git fetch origin pull/$argv/head:pr$argv;" #checkout to the pull request branch

alias gpg="gpg2"
alias vimdiff="nvim -d"
alias vim="nvim"
alias ls="exa -la"

# Docker
function docker-clean --description 'Remove docker container with "exited" status'
  docker rm (docker ps -a -q -f status=exited)
end
