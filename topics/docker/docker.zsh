# topics/docker.zsh
#
# Docker and Docker Compose aliases.
# See also: zsh/functions/ for interactive functions (dlog, dstop, dcleanup, etc.)

# ---------------------------------------------------------------------------
# Docker
# ---------------------------------------------------------------------------
alias d-last="docker ps -l -q"         # zref: Latest container ID
alias d-ps="docker ps"                 # zref: Running containers
alias d-psa="docker ps -a"             # zref: All containers (including stopped)
alias d-images="docker images"         # zref: List images
alias d-run="docker run -i -t -P"      # zref: Run interactive container
alias d-exec="docker exec -i -t"       # zref: Execute in running container

# ---------------------------------------------------------------------------
# Docker Compose
# ---------------------------------------------------------------------------
alias dc-up="docker compose up -d"     # zref: Start in background
alias dc-ps="docker compose ps"        # zref: List services
alias dc-stop="docker compose stop"    # zref: Stop services (keep containers)
alias dc-list="docker compose ps -a"   # zref: All services including stopped

# zref: dc-down: Stop and remove Docker Compose stack
#
# Usage:
#   dc-down        Stop containers and remove networks
#   dc-down -v     Also remove volumes
#   dc-down -i     Also remove images
dc-down() {
    if [[ "$1" == "-v" || "$1" == "--volumes" ]]; then
        echo "Stopping and removing containers, networks, and volumes..."
        docker compose down --volumes
    elif [[ "$1" == "-i" || "$1" == "--images" ]]; then
        echo "Stopping and removing containers, networks, and images..."
        docker compose down --rmi all
    else
        echo "Stopping and removing containers and networks..."
        docker compose down
    fi
}

# zref: dc-exec: Execute a command in a running Docker Compose service
#
# Usage:
#   dc-exec web                   bash into the web service
#   dc-exec db psql -U postgres   run psql in the db service
dc-exec() {
    if [[ -z "$1" ]]; then
        echo "Usage: dc-exec <service> [command]"
        echo "\nRunning services:"
        docker compose ps --services
        return 1
    fi

    local service=$1
    shift
    local cmd=${*:-bash}

    docker compose exec "$service" $cmd
}

# zref: dc-logs: Follow Docker Compose logs
#
# Usage:
#   dc-logs              All services
#   dc-logs web          Specific service
#   dc-logs web 50       Last 50 lines from a service
dc-logs() {
    local service=${1:-}
    local lines=${2:-100}

    if [[ -n "$service" ]]; then
        docker compose logs -f --tail="$lines" "$service"
    else
        docker compose logs -f --tail="$lines"
    fi
}

# zref: dc-bash: Bash into a running container by fuzzy name match. dc-bash <container-pattern>
#
# Usage:
#   dc-bash <container-pattern>
dc-bash() {
    if [[ -z "$1" ]]; then
        echo "Usage: docker-bash <container-pattern>"
        echo "\nRunning containers:"
        docker ps --format "  {{.Names}}"
        return 1
    fi

    local container
    container=$(docker ps --format '{{.Names}}' | grep -i "$1" | head -1)

    if [[ -z "$container" ]]; then
        echo "No running container matching '$1'"
        return 1
    fi

    docker exec -it "$container" bash
}

# zref: Clean up unused Docker resources (containers, images, volumes) with confirmation
d-cleanup() {
    echo "Current usage:"
    docker system df

    echo -n "\nClean up unused resources? (y/N): "
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Cancelled"
        return 0
    fi

    docker container prune -f
    docker image prune -f
    docker volume prune -f

    echo "\nAfter cleanup:"
    docker system df
}

# zref: d-log: Tail logs from a running container by fuzzy name match. dc-log <container-pattern> [lines]
#
# Usage:
#   dc-log <container-pattern> [lines]
d-log() {
    if [[ -z "$1" ]]; then
        echo "Usage: docker-log <container-pattern> [lines]"
        echo "\nRunning containers:"
        docker ps --format "  {{.Names}}"
        return 1
    fi

    local lines=${2:-100}
    local container
    container=$(docker ps --format '{{.Names}}' | grep -i "$1" | head -1)

    if [[ -z "$container" ]]; then
        echo "No running container matching '$1'"
        return 1
    fi

    docker logs -f --tail="$lines" "$container"
}
