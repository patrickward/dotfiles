# ------------------------------------
# Docker
# ------------------------------------

# Get latest container ID
alias dlast="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stopped containers
alias dpsa="docker ps -a"

# Get images
alias dimages="docker images"

# Run interactive container, e.g., $dki base /bin/bash
alias drun="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dexec="docker exec -i -t"

# Prune all unused containers
alias dprune="docker container prune"

# ------------------------------------
# Docker compose
# ------------------------------------
alias dcup="docker compose up -d"
alias dcps="docker compose ps"
alias dcstop="docker compose stop"

# Alias to enter terminal of running container by name
# Example: dcbash my_container
alias dcbash="docker compose exec $1 bash"

# List all docker containers (including stopped) for current compose project
alias dclist="docker compose ps -a"

# SEE ALL dc* functions in dotfiles/zsh/functions

# ------------------------------------
# Archived
#
# NOTE: many of these were moved to dotsfiles/zsh/functions for safety and confirmation
#
# ------------------------------------

# Get container IP
# alias dkip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
# alias dkrd="docker run -d -P"

# Stop all containers
# dkstop() { docker stop $(docker ps -a -q); }

# Remove all containers
# dkrmc() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
# alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
# dkrmi() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test
# dkbuild() { docker build -t=$1 .; }

# Show all alias related docker
# dkalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
# dkbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

