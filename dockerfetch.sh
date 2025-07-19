#!/bin/bash

# Colors
BOLD='\033[1m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
NC='\033[0m'

# Check Docker status
if ! docker info >/dev/null 2>&1; then
  echo -e "${CYAN}🐳  DockerFetch v1.0${NC}  |  ${BOLD}Docker not running${NC}"
  exit 1
fi

# Host info
HOSTNAME=$(hostname)
UPTIME=$(ps -p $(pgrep dockerd) -o etime= | awk '{$1=$1};1')

# Docker info
DOCKER_VERSION=$(docker -v | cut -d ' ' -f3 | tr -d ',')
OS_ARCH=$(docker info --format '{{.OSType}}/{{.Architecture}}')
ROOT_DIR=$(docker info --format '{{.DockerRootDir}}')

# Containers
RUNNING=$(docker ps -q | wc -l)
TOTAL=$(docker ps -a -q | wc -l)
STOPPED=$((TOTAL - RUNNING))

# Images
IMAGE_COUNT=$(docker images -q | sort -u | wc -l)
DANGLING=$(docker images -f "dangling=true" -q | wc -l)
IMAGE_SIZE=$(docker system df | awk '/^Images/ { print $4 }')
RECENT_IMAGE=$(docker images --format '{{.Repository}}:{{.Tag}} ({{.CreatedSince}})' | head -n 1)

# Compose projects
COMPOSE_PROJECTS=$(docker ps --format '{{.Labels}}' | grep -o 'com.docker.compose.project=[^,]*' | cut -d= -f2 | sort | uniq | wc -l)

# Port mappings
PORTS=$(docker ps --format '{{.Ports}}' | grep -v '^$' | wc -l)

# Top container stats
STATS=$(docker stats --no-stream --format "{{.Name}}│{{.CPUPerc}}│{{.MemUsage}}" | head -n 3)

# Output
echo -e "${CYAN}🐳  DockerFetch v1.0${NC}  |  Host: ${HOSTNAME}  |  Uptime: ${UPTIME}\n"

echo -e "🔧 Docker:   ${GREEN}✅ Running${NC} | v${DOCKER_VERSION} | ${OS_ARCH} | Root: ${ROOT_DIR}\n"

printf "📦 Containers       : %s running / %s stopped / %s total\n" "$RUNNING" "$STOPPED" "$TOTAL"
printf "🧊 Images           : %s total (%s dangling)\n" "$IMAGE_COUNT" "$DANGLING"
printf "📁 Compose Projects : %s\n" "$COMPOSE_PROJECTS"
printf "💾 Image Size       : %s\n" "$IMAGE_SIZE"
printf "🕓 Recent Image     : %s\n" "$RECENT_IMAGE"
printf "🔀 Port Mappings    : %s\n\n" "$PORTS"
printf "💻 Docker Processes :\n"
docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.RunningFor}}\t{{.Status}}' | awk 'NR==1{print "   "$0}'
docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.RunningFor}}\t{{.Status}}' | awk 'NR>1{print "   "$0}'

printf "\n"