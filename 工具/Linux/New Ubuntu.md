
### 磁盘分区  gparted
```sh
sudo apt install -y gparted
```
### 换源+ros
```sh
sudo apt install -y wget && wget http://fishros.com/install -O fishros && . fishros
```
### vscode
```sh
cd ~/Downloads && sudo apt install -y wget && wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/019f4d1419fbc8219a181fab7892ebccf7ee29a2/code_1.87.0-1709078641_amd64.deb
sudo dpkg -i code_1.87.0-1709078641_amd64.deb
```
### Qt5.14.2
```sh
#install auto or manu
cd ~/Downloads
sudo apt install -y wget && wget https://download.qt.io/archive/qt/5.14/5.14.2/qt-opensource-linux-x64-5.14.2.run&&chmod 777 ./qt-opensource-linux-x64-5.14.2.run
sudo bash -c 'echo "deb http://security.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list'  #添加源
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A 54404762BBB6E853
sudo apt update
sudo apt install -y libc6-dev libc6
strings /lib/x86_64-linux-gnu/libc.so.6 | grep GLIBC_
./qt-opensource-linux-x64-5.14.2.run 
```
最后**设置环境变量**
```bash
#/etc/profile
export PATH="/home/photinia/3rd_party/Qt/Tools/QtCreator/bin:$PATH"
export PATH="/home/photinia/3rd_party/Qt/5.15.2/gcc_64/bin:$PATH"
```
### clash_linux
```sh
cd ~ && mkdir 3rd && cd 3rd
git clone https://github.com/Photin1a/clash_linux.git && cd clash_linux
tar -xvf cfw.tar.xz
rm cfw.tar.xz
```
### Todesk远程
```sh
cd ~/Downloads && sudo apt install -y wget && wget https://dl.todesk.com/linux/todesk-v4.7.2.0-amd64.deb
sudo dpkg -i todesk-v4.7.2.0-amd64.deb
```
### 搜狗输入法 version<=20.04
[csdn](https://blog.csdn.net/qq2399431200/article/details/123917194)
```sh
# 先卸载掉fcitx，及其所有相关的软件
sudo apt -y --purge remove *fcitx*
sudo apt clean *fcitx*

sudo apt install -y fcitx

cd ~/Downloads && sudo apt install -y wget && wget https://ime-sec.gtimg.com/202403071420/22bada687d64a1ed174182e4fdbc9f84/pc/dl/gzindex/1680521603/sogoupinyin_4.2.1.145_amd64.deb
sudo dpkg -i sogoupinyin_4.2.1.145_amd64.deb
``
