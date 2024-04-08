# Docker



## Commands


```bash
docker-compose run postgres psql -h hostname -U username -d dbname


docker compose run postgres psql -h hostname -U username -d dbname
```



```bash
docker volume ls

docker ps -a

docker stop $(docker ps -a -q)

docker rm $(docker ps -a -q)

docker volume ls --format "{{.Name}}" | while read -r line; do docker volume rm "${line}"; done

docker system prune -a

docker build - < Dockerfile
```


```bash
docker stop "$(docker ps -a -q)"; \
docker rm --force "$(docker ps -a -q)"; \
docker system prune --all --force; \
while read -r volume_name; do docker volume rm --force "${volume_name}"; done < <(docker volume ls --format "{{.Name}}")
```




## Install Docker on openSUSE Tumbleweed

```bash
sudo zypper install docker \
                    docker-compose \
                    docker-compose-switch

sudo systemctl enable docker

sudo usermod -G docker -a "${USER}"

sudo systemctl restart docker

docker version
```



## Install Docker on Fedora

```bash
sudo dnf remove \
    docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-selinux \
    docker-engine-selinux \
    docker-engine

sudo dnf -y install dnf-plugins-core

sudo dnf config-manager \
    --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io

# If prompted to accept the GPG key, verify that the fingerprint matches
# 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35, and if so, accept it.

sudo systemctl start docker

groupadd docker

usermod -aG docker "${USER}"

newgrp docker

systemctl enable docker.service

systemctl enable containerd.service
```



## References

- [Install Docker](https://docs.docker.com/engine/install/)
- [Docker - openSUSE](https://en.opensuse.org/Docker)
- [Overview of docker compose CLI](https://docs.docker.com/compose/reference/)
- [docker container](https://docs.docker.com/reference/cli/docker/container/)
