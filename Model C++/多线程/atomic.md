# 1、Introduce
C++中原子变量（atomic）是一种多线程编程中常用的同步机制，它能够确保对共享变量的操作在执行时不会被其他线程的操作干扰，从而避免竞态条件（race condition）和死锁（deadlock）等问题。

# 2、Use

## 2.1 构造函数
```cpp
#include <atomic>

//默认构造    使对象处于未初始化状态
std::atomic<bool> ready;

//构造初始化
std::atomic<bool> ready(false);

//无拷贝/移动构造
atomic (const atomic&) = delete;
```
## 2.2 is_lock_free
用于检查当前atomic对象是否支持无锁操作。支持返回true，不支持返回false。调用此成员函数不会启动任何数据竞争。
```cpp
bool is_lock_free() const volatile noexcept;
bool is_lock_free() const noexcept;
```
