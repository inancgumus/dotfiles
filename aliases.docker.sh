alias docker_remove_zombies='docker rmi -f $(docker images -f "dangling=true" -q)'
