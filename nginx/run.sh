ID=$(sudo docker run -d --privileged boynux:nginx)
VNET="vnet${ID:0:8}"
IP="$1"

docker exec $ID ip link add $VNET type dummy
docker exec $ID ip link set dev $VNET name eth1
docker exec $ID ip link set eth1 up
docker exec $ID ip addr add "$IP/32" dev eth1
docker exec $ID ip rout add "$IP" dev eth1 scope link

echo $ID
