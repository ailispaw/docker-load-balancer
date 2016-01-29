LVS Load balancing with Docker
=============================

## Build Demo Environment

```bash
[docker@docker-root ~]$ sudo pkg install ipvsadm
[docker@docker-root ~]$ sudo pkg install criu # to install iproute2
[docker@docker-root ~]$ wget https://github.com/ailispaw/docker-load-balancer/archive/caddy.zip
[docker@docker-root ~]$ unzip caddy.zip
[docker@docker-root ~]$ cd docker-load-balancer-caddy
[docker@docker-root docker-load-balancer-caddy]$ docker build -t ailispaw/caddy caddy
[docker@docker-root docker-load-balancer-caddy]$ sudo ./run.sh 172.20.10.1
Creating docker containers ...
Adding route ...
Press ctrl-c to cancel
```

## Test Load balancing

```bash
[docker@docker-root ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                       NAMES
ce3453c476bc        ailispaw/caddy      "/usr/bin/dumb-init /"   11 seconds ago      Up 11 seconds       80/tcp, 443/tcp, 2015/tcp   romantic_morse
36d42ffc3afa        ailispaw/caddy      "/usr/bin/dumb-init /"   11 seconds ago      Up 11 seconds       80/tcp, 443/tcp, 2015/tcp   clever_brattain
caa20494cc44        ailispaw/caddy      "/usr/bin/dumb-init /"   11 seconds ago      Up 11 seconds       80/tcp, 443/tcp, 2015/tcp   sharp_bardeen
[docker@docker-root ~]$ wget -qO- 172.20.10.1:2015
<html>
    <head>
        <title>Host: ce3453c476bc</title>
    </head>
    <body>
        <p>This host id is: ce3453c476bc
    </body>
</html>
[docker@docker-root ~]$ wget -qO- 172.20.10.1:2015
<html>
    <head>
        <title>Host: 36d42ffc3afa</title>
    </head>
    <body>
        <p>This host id is: 36d42ffc3afa
    </body>
</html>
[docker@docker-root ~]$ wget -qO- 172.20.10.1:2015
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
