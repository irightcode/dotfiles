#!/bin/sh

alias dk='docker'
alias dki='docker images'
alias dks='docker service'
alias dkrm='docker rm'
alias dkup='docker compose up -d'
alias dkdown='docker compose down'
alias dkl='docker logs'
alias dklf='docker logs -f'
alias dkflush='docker rm `docker ps --no-trunc -aq`'
alias dkflush2='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias dkt='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"'
alias dkps="docker ps --format '{{.ID}} ~ {{.Names}} ~ {{.Status}} ~ {{.Image}}'"
alias dkswarm='export DOCKER_HOST=tcp://tip-swarm-master.dlas1.ucloud.int:2375; echo $DOCKER_HOST'

dkln() {
  docker logs -f `docker ps | grep $1 | awk '{print $1}'`
}

dkstop() {
  docker stop $(docker ps -a -q)
}

dkssh() {
  if [ $# -eq 0 ]; then
    host=tip-swarm-master
  else
    host="tip-swarm-worker-$1"
  fi
  ssh -i ~/repos/~charlesr/terraform-swarm/ist-terraform-ssh.pem "ubuntu@$host"
}

dkclean() {
  docker rm $(docker ps --all -q -f status=exited)
  docker volume rm $(docker volume ls -qf dangling=true)
}

dkprune() {
  docker system prune -af
}

dktop() {
  docker stats --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}  {{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}"
}

dkstats() {
  if [ $# -eq 0 ]
    then docker stats --no-stream;
    else docker stats --no-stream | grep $1;
  fi
}

dke() {
  docker exec -it $1 /bin/sh
}

dkexe() {
  docker exec -it $1 $2
}

dkreboot() {
  osascript -e 'quit app "Docker"'
  countdown 2
  open -a Docker
  echo "Restarting Docker engine"
  countdown 120
}

dkstate() {
  docker inspect $1 | jq .[0].State
}

dksb() {
  docker service scale $1=0
  sleep 2
  docker service scale $1=$2
}

dk-mongo() {
  mongoLabel=`docker ps | grep mongo | awk '{print $NF}'`
  docker exec -it $mongoLabel mongo "$@"
}

dk-redis() {
  redisLabel=`docker ps | grep redis | awk '{print $NF}'`
  docker exec -it $redisLabel redis-cli
}

dk-vault() {
  redisLabel=`docker ps | grep vault | awk '{print $NF}'`
  docker exec -it $redisLabel sh
}

dk-influx() {
  redisLabel=`docker ps | grep influx | awk '{print $NF}'`
  docker exec -it $redisLabel influx
}
