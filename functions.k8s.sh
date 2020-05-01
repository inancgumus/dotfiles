function kind-restart {
	for CONTAINER in worker external-load-balancer control-plane control-plane2 worker3 control-plane3 worker2; do
	  docker start kind-${CONTAINER}
	  sleep 10
	  docker exec -ti kind-${CONTAINER} ip a | grep 172.17
	  echo
	done
}