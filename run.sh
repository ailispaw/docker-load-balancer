#!/bin/bash

cleanup() {
    echo "Removing routes ..."
    sudo ip route del $VIRTUAL_IP via 127.0.0.1

    echo "Cleaning up docker containers ..."
    sudo docker rm -f $ID1
    sudo docker rm -f $ID2
    sudo docker rm -f $ID3

    ipvsadm -C
    exit
}

VIRTUAL_IP=$1

ipvsadm -A -t $VIRTUAL_IP:80 -s wlc

echo "Creating docker containers ..."

ID1=$(./caddy/run.sh $VIRTUAL_IP)
ID2=$(./caddy/run.sh $VIRTUAL_IP)
ID3=$(./caddy/run.sh $VIRTUAL_IP)

IP1=$(sudo docker inspect -f '{{.NetworkSettings.IPAddress}}' $ID1)
ipvsadm -a -t $VIRTUAL_IP:80 -r $IP1 -g
IP2=$(sudo docker inspect -f '{{.NetworkSettings.IPAddress}}' $ID2)
ipvsadm -a -t $VIRTUAL_IP:80 -r $IP2 -g
IP3=$(sudo docker inspect -f '{{.NetworkSettings.IPAddress}}' $ID3)
ipvsadm -a -t $VIRTUAL_IP:80 -r $IP3 -g

ipvsadm -Ln

echo "Adding route ..."
sudo ip route add $VIRTUAL_IP via 127.0.0.1

echo "Press ctrl-c to cancel"
trap cleanup SIGINT

while true
do
    sleep 1
done

