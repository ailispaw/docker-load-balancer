LVS Load balancing with Docker
=============================

## Build Demo Environment

```bash
[docker@docker-root ~]$ sudo modprobe ip_vs
[docker@docker-root ~]$ wget https://github.com/ailispaw/docker-load-balancer/archive/docker-root.zip
[docker@docker-root ~]$ unzip docker-root.zip
[docker@docker-root ~]$ cd docker-load-balancer-docker-root
[docker@docker-root docker-load-balancer-docker-root]$ docker build -t boynux:nginx nginx
[docker@docker-root docker-load-balancer-docker-root]$ docker build -t boynux:ipvs ipvs
[docker@docker-root docker-load-balancer-docker-root]$ ./run.sh 172.20.10.1
Creating docker containers ...
Adding route ...
Press ctrl-c to cancel
```

## Test Load balancing

```bash
[docker@docker-root ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
302f7654eab4        boynux:ipvs         "/bin/sh -c /entrypoi"   33 seconds ago      Up 33 seconds                           clever_hodgkin
ad5176ca4f10        boynux:nginx        "/entrypoint.sh"         34 seconds ago      Up 34 seconds       80/tcp, 443/tcp     evil_morse
1fad6e3e75cc        boynux:nginx        "/entrypoint.sh"         35 seconds ago      Up 34 seconds       80/tcp, 443/tcp     suspicious_pasteur
f0e856a23dd9        boynux:nginx        "/entrypoint.sh"         35 seconds ago      Up 35 seconds       80/tcp, 443/tcp     trusting_feynman
[docker@docker-root ~]$ wget -qO- 172.20.10.1
<html>
    <head>
        <title>Host: ad5176ca4f10</title>
    </head>
    <body>
        <p>This host id is: ad5176ca4f10
    </body>
</html>
[docker@docker-root ~]$ wget -qO- 172.20.10.1
<html>
    <head>
        <title>Host: 1fad6e3e75cc</title>
    </head>
    <body>
        <p>This host id is: 1fad6e3e75cc
    </body>
</html>
[docker@docker-root ~]$ wget -qO- 172.20.10.1
<html>
    <head>
        <title>Host: f0e856a23dd9</title>
    </head>
    <body>
        <p>This host id is: f0e856a23dd9
    </body>
</html>
```

For more info:

* http://bit.ly/1zTbsTt
* http://bit.ly/1Hb6QKQ
