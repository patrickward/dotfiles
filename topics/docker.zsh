# topics/docker.zsh
#
# Docker and Docker Compose aliases.
# See also: zsh/functions/ for interactive functions (dlog, dstop, dcleanup, etc.)

# ---------------------------------------------------------------------------
# Docker
# ---------------------------------------------------------------------------
alias dlast="docker ps -l -q"         # Latest container ID
alias dps="docker ps"                  # Running containers
alias dpsa="docker ps -a"              # All containers (including stopped)
alias dimages="docker images"          # List images
alias drun="docker run -i -t -P"      # Run interactive container
alias dexec="docker exec -i -t"       # Execute in running container
alias dprune="docker container prune" # Remove stopped containers

# ---------------------------------------------------------------------------
# Docker Compose
# ---------------------------------------------------------------------------
alias dcup="docker compose up -d"    # Start in background
alias dcps="docker compose ps"        # List services
alias dcstop="docker compose stop"    # Stop services (keep containers)
alias dclist="docker compose ps -a"   # All services including stopped
