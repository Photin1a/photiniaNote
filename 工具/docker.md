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


一、docker命令
```bash
 #-------------------------------------docker启动与关闭
    # 启动docker
    systemctl start docker
     
    # 关闭docker
    systemctl stop docker
     
    # 重启docker
    systemctl restart docker
     
    # docker设置随服务启动而自启动
    systemctl enable docker
     
     
    #-------------------------------------docker状态
    # 查看docker 运行状态
    systemctl status docker
     
    # 查看docker 版本号信息
    docker version
    docker info
     
    #-------------------------------------docker帮助
    # 忘记某些命令时，进行查看与回顾
    docker --help
     
    #如果忘记了 run命令 不知道可以带哪些参数 可以这样使用
    docker run --help

```
   
二、docker 镜像命令
```bash
#-------------------------------------镜像（增）
    # 拉取镜像（增）
    # 不加tag(版本号) 即拉取docker仓库中 该镜像的最新版本latest 加:tag 则是拉取指定版本
    # https://hub.docker.com/search?type=image （去官网镜像搜索）
    docker pull 镜像名 
    docker pull 镜像名:tag
     
    #-------------------------------------镜像（查）
    # 查看镜像列表（查）
    docker images
     
     
    # 搜索镜像（查）
    docker search 镜像名
    docker search --filter=STARS=9000 mysql 搜索 STARS >9000的 mysql 镜像
     
    #-------------------------------------镜像（删）
    # 删除镜像（删）
    # 删除一个
    docker rmi -f 镜像名/镜像ID
     
    # 删除多个 其镜像ID或镜像用用空格隔开即可 
    docker rmi -f 镜像名/镜像ID 镜像名/镜像ID 镜像名/镜像ID
     
    # 删除全部镜像  -a 意思为显示全部, -q 意思为只显示ID
    docker rmi -f $(docker images -aq)
     
    # 强制删除镜像
    docker image rm 镜像名称/镜像ID
     
    #-------------------------------------镜像（存）
    # 保存镜像（存）
    docker save 镜像名/镜像ID -o 镜像保存在哪个位置与名字
    # 示例
    docker save tomcat -o /myimg.tar
     
    # 加载镜像（增）
    docker load -i 镜像保存文件位置
    # 示例
    docker load -i myimg.tar

    镜像标签：

    有时候，我们需要对一个镜像进行分类或者版本迭代操作。

    比如：我们一个微服务已经打为docker镜像，

    但是想根据环境进行区分为develop环境与alpha环境；

    这时候，我们就可以使用Tag，来进对镜像做一个标签添加，

    从而行进区分；版本迭代逻辑也是一样，根据不同的tag进行区分

        app:1.0.0 基础镜像
        # 分离为开发环境
        app:develop-1.0.0   
        # 分离为alpha环境
        app:alpha-1.0.0   
```
    
三、docker 容器命令
```bash
   # 查看所有容器列表（包含 正在运行 和 已停止的）
    docker ps -a
     
    # 停止容器
    docker stop 容器ID/容器名
     
    # 重启容器
    docker restart 容器ID/容器名
     
    # 启动容器
    docker start 容器ID/容器名
     
    # kill 容器
    docker kill 容器ID/容器名
     
    # ----------------容器文件拷贝 （无论容器是否开启 都可以进行拷贝）
     
    # docker cp 容器ID/名称:文件路径  要拷贝到外部的路径 | 要拷贝到外部的路径  容器ID/名称:文件路径
     
    # 从容器内 拷出
    docker cp 容器ID/名称: 容器内路径  容器外路径
     
    # 示例：
    docker cp nginx:/etc/nginx/conf.d /data/applications/nginx/conf/conf.d
     
    # 从外部 拷贝文件到容器内
    docker  cp 容器外路径 容器ID/名称: 容器内路径
     
    # ----------------查看容器日志
    docker logs -f --tail=要查看末尾多少行 默认all 容器ID
     
    # 示例：
    docker logs -f -t --tail 1000 2ab447816a66
     
    # ----------------更换容器名
    docker rename 容器ID/容器名 新容器名
```
 

1、运行容器
```bash
 # 运行一个容器
    # -restart=always 该容器随docker服务启动而自动启动
     
    docker run -it -d --name 要取的别名 镜像名:Tag /bin/bash 

    命令参数说明：

    -d：后台运行容器

    -p：端口映射，格式为主机端口:容器端口

    -e：设置环境变量，这里设置的是root密码

    --name：设置容器别名

    -v 挂载文件，格式为：宿主机绝对路径目录:容器内目录，

    比如我们使用：-v /usr/local/mysql/logs:/var/log/mysql

    将mysql容器存放日志文件的目录：/var/log/mysql挂载在宿主机的/usr/local/mysql/logs下

    # 示例
    docker run --name mysql \
    -v /myapp/mysql:/var/lib/mysql \
    -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=123456 \
    -d mysql:8.0.19

```
   
2、删除容器 
```bash
# 停止运行的 redis 容器 
    docker stop 容器名/容器ID
     
    #删除一个容器
    docker rm -f 容器名/容器ID
     
    #删除多个容器 空格隔开要删除的容器名或容器ID
    docker rm -f 容器名/容器ID 容器名/容器ID 容器名/容器ID
     
    #删除全部容器
    docker rm -f $(docker ps -aq)
```
    

3、进入容器  

```bash
    #进入容器(方式一)
    docker exec -it 容器名/容器ID /bin/bash
     
    #进入容器(方式二) --- 不推荐使用
    docker attach 容器名/容器ID
```

4、退出容器

```bash
    # 直接退出 （如果没有添加-d 参数(持久化运行容器) 该容器会被关闭 ） 
    exit
     
    # 优雅退出 （无论是否添加-d 参数 容器都不会被关闭）
    Ctrl + p + q
```
     

四、docker 运维命令
1、防火墙命令 
```bash
   #------------------------------防火墙命令
     
    // 1.检验防火墙是否启动
    firewall-cmd --state
     
    // 2. 检查端口是否启动：
    firewall-cmd --permanent --zone=public --list-ports
     
    //3.开启 8080 端口：
    firewall-cmd --zone=public --add-port=8080/tcp --permanent
     
    //4.重新启动防火墙
    firewall-cmd --reload
     
    #永久关闭防火墙,和SElinux
    systemctl stop firewalld
    systemctl disable firewalld
     
    setenforce 0
    sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
```
 

 2、构建镜像
```bash
    # 构建一个新的镜像
    docker commit -m="提交信息" -a="作者信息" 容器名/容器ID 提交后的镜像名:Tag
```


3、其他 

```bash
    # 查看docker磁盘占用总体情况
    du -hs /var/lib/docker/ 
     
    # 查看Docker的磁盘使用具体情况
    docker system df
     
    # ----------------------------删除 无用的容器和 镜像
    #  删除异常停止的容器
    docker rm `docker ps -a | grep Exited | awk '{print $1}'` 
     
    #  删除名称或标签为none的镜像
    docker rmi -f  `docker images | grep '<none>' | awk '{print $3}'`
     
    #  清除所有无容器使用的镜像 (只要是镜像无容器使用（容器正常运行）都会被删除，包括容器临时停止)
    docker system prune -a
     
     
    # ----------------------------查找大文件
    find / -type f -size +100M -print0 | xargs -0 du -h | sort -nr
     
    # 查找指定docker使用目录下大于指定大小文件
    find / -type f -size +100M -print0 | xargs -0 du -h | sort -nr |grep '/var/lib/docker/overlay2/*'
```

五、docker 的 Dockerfile

```bash
 Dockerfile是用来构建Docker镜像的文本文件，是由一条条构建镜像所需的指令和参数构成的脚本。

    构建三步骤：

    1、编写Dockerfile文件

    2、docker build命令构建镜像

    3、docker run依镜像运行容器实例

    # 构建镜像 （需要在Dockerfile同级目录下构建）
    docker build -t cat:1.0 .
     
    # 说明（-t：设置 镜像的名字及tag）（最后的. 为当前目录）

    FROM
    基础镜像，当前新镜像是基于哪个镜像的，指定一个已经存在的镜像作为模板，第一条必须是from
     
    MAINTAINER
    镜像维护者的姓名和邮箱地址
     
    RUN
    容器构建时需要运行的命令
    两种格式
     
    shell格式（1）
    RUN yum -y install vim
     
    exec格式（2）
    ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
     
    注意：RUN 是在 docker build时运行
     
    EXPOSE
    当前容器对外暴露出的端口
     
    WORKDIR
    指定在创建容器后，终端默认登陆的进来工作目录，一个落脚点
     
    USER
    指定该镜像以什么样的用户去执行，如果都不指定，默认是root
     
    ENV
    用来在构建镜像过程中设置环境变量
     
    ENV MY_PATH /usr/mytest
    这个环境变量可以在后续的任何RUN指令中使用，这就如同在命令前面指定了环境变量前缀一样；
    也可以在其它指令中直接使用这些环境变量，
     
    比如：WORKDIR $MY_PATH
     
    ADD
    将宿主机目录下的文件拷贝进镜像且会自动处理URL和解压tar压缩包
     
    COPY
    类似ADD，拷贝文件和目录到镜像中。 
     
    将从构建上下文目录中 <源路径> 的文件/目录复制到新的一层的镜像内的 <目标路径> 位置
    COPY src dest
    COPY ["src", "dest"]
    <src源路径>：源文件或者源目录
    <dest目标路径>：容器内的指定路径，该路径不用事先建好，路径不存在的话，会自动创建。
     
    VOLUME
    容器数据卷，用于数据保存和持久化工作
     
    CMD
    指定容器启动后的要干的事情
     
    注意：Dockerfile 中可以有多个 CMD 指令，
    但只有最后一个生效，CMD 会被 docker run 之后的参数替换
```

六、docker 的 docker-compose.yml
```bash
  Compose 是 Docker 公司推出的一个工具软件，可以管理多个 Docker 容器组成一个应用。你需要定义一个 YAML 格式的配置文件docker-compose.yml，写好多个容器之间的调用关系。然后，只要一个命令，就能同时启动/关闭这些容器。

    简而言之：

    ​​​​​​​Docker-Compose是Docker官方的开源项目， 负责实现对Docker容器集群的快速编排。

    docker-compose -h                           # 查看帮助
     
    docker-compose up                           # 启动所有docker-compose服务
    docker-compose up -d                        # 启动所有docker-compose服务并后台运行
     
    docker-compose down                         # 停止并删除容器、网络、卷、镜像
    docker-compose exec  yml里面的服务id         # 进入容器实例内部yml文件中写的服务id /bin/bash
     
    docker-compose ps                      # 展示当前docker-compose编排过的运行的所有容器
    docker-compose top                     # 展示当前docker-compose编排过的容器进程
     
    docker-compose logs  yml里面的服务id     # 查看容器输出日志
     
    docker-compose config     # 检查配置
    docker-compose config -q  # 检查配置，有问题才有输出
     
    docker-compose restart   # 重启服务
    docker-compose start     # 启动服务
    docker-compose stop      # 停止服务
```
---

>https://blog.csdn.net/Pan_peter/article/details/128860771