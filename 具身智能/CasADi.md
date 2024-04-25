# 环境安装
```bash
#eigen3.4
wget https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.zip
unzip eigen-3.4.0.zip &&cd eigen-3.4.0
mkdir build
cd build
cmake ..
make
sudo make install
```

```bash
#ipopt
sudo apt-get install -y gfortran pkg-config coinor-libipopt-dev
git clone https://github.com/coin-or/Ipopt.git
cd Ipopt && mkdir build
cd build
./configure
make 
sudo make install
```

```bash
#CasADi
git clone --recursive https://github.com/casadi/casadi.git
cd casadi && mkdir build 
cd build 
cmake .. -DCMAKE_BUILD_TYPE=RELEASE -DWITH_IPOPT=true
make
sudo make install
```


安装完成后编译工程会报一个错误，可以通过如下操作修复：

sudo vim /usr/include/coin/IpSmartPtr.hpp

修改文件的预处理部分，如下内容（注释为修改部分的两条语句）：

    #define HAVE_CSTDDEF // 修改部分
    #ifdef HAVE_CSTDDEF
    # include <cstddef>
    #else
    # ifdef HAVE_STDDEF_H
    #  include <stddef.h>
    # else
    #  error "don't have header file for stddef"
    # endif
    #endif
    #undef HAVE_CSTDDEF // 修改部分
