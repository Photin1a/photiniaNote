## 安装
```bash
sudo apt install docker.io

sudo groupadd docker
sudo usermod -aG docker  photinia
newgrp docker
cd /home/photinia/ && mkdir .docker
sudo chown photinia:photinia /home/photinia/.docker -R
sudo chmod g+rwx "/home/photinia/.docker" -R
sudo chmod 666 /var/run/docker.sock
```

```bash
sudo apt install docker.io
```
```bash
systemctl start docker #启动docker
systemctl restart  docker #重启docker
docker systemctl stop docker  #关闭docker

sudo service docker restart #重启docker服务
docker service docker stop  #关闭docker服务
sudo systemctl daemon-reload #守护进程重启
```

## 拉取镜像
```bash
docker pull <镜像名称>
```

## 启动镜像
```bash
docker images   #查看所有镜像

docker run -it <镜像名称>  #启动镜像
docker run -it <镜像 ID>  #启动镜像

exit  退出镜像交互终端

```

- 列出本机的所有 image 文件：`docker image ls`
- 删除 image 文件：`docker image rm [imageName]`
- 列出本机正在运行的容器：`docker container ls -l`
- 列出本机所有容器，包括终止运行的容器：`docker container ls -l --all`
- 删除容器文件：`docker container rm [containerID]`
- 导出容器：`docker export [OPTIONS] CONTAINER`
- 导入容器：`docker import [OPTIONS] file|URL|- [REPOSITORY[:TAG]]`## 