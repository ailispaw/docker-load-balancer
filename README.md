LVS Load balancing with Docker
=============================

## Build Demo Environment

```bash
[bargee@barge ~]$ sudo pkg install ipvsadm
[bargee@barge ~]$ sudo pkg install criu # to install iproute2
[bargee@barge ~]$ wget https://github.com/ailispaw/docker-load-balancer/archive/caddy.zip
[bargee@barge ~]$ unzip caddy.zip
[bargee@barge ~]$ cd docker-load-balancer-caddy
[bargee@barge docker-load-balancer-caddy]$ docker build -t ailispaw/caddy caddy
[bargee@barge docker-load-balancer-caddy]$ sudo ./run.sh 172.20.10.1
Creating docker containers ...
Adding route ...
Press ctrl-c to cancel
```

## Test Load balancing

```bash
[bargee@barge ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                       NAMES
ce3453c476bc        ailispaw/caddy      "/usr/bin/dumb-init /"   11 seconds ago      Up 11 seconds       80/tcp, 443/tcp, 2015/tcp   romantic_morse
36d42ffc3afa        ailispaw/caddy      "/usr/bin/dumb-init /"   11 seconds ago      Up 11 seconds       80/tcp, 443/tcp, 2015/tcp   clever_brattain
caa20494cc44        ailispaw/caddy      "/usr/bin/dumb-init /"   11 seconds ago      Up 11 seconds       80/tcp, 443/tcp, 2015/tcp   sharp_bardeen
[bargee@barge ~]$ wget -qO- 172.20.10.1
<html>
    <head>
        <title>Host: ce3453c476bc</title>
    </head>
    <body>
        <p>This host id is: ce3453c476bc
    </body>
</html>
[bargee@barge ~]$ wget -qO- 172.20.10.1
<html>
    <head>
        <title>Host: 36d42ffc3afa</title>
    </head>
    <body>
        <p>This host id is: 36d42ffc3afa
    </body>
</html>
[bargee@barge ~]$ wget -qO- 172.20.10.1
<html>
    <head>
        <title>Host: caa20494cc44</title>
    </head>
    <body>
        <p>This host id is: caa20494cc44
    </body>
</html>
```

For more info:

* http://bit.ly/1zTbsTt
* http://bit.ly/1Hb6QKQ
