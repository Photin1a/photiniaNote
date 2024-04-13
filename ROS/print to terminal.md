分为5类：
* #普通打印`ROS_INFO("message")`
* #流式打印`ROS_INFO_STREAM("msg is: " << x)`
* #单次打印`只触发一次，ROS_INFO_ONCE("msg")`
* #条件打印`ROS_INFO_COND(condition > 0, "msg")`
* #LOG打印`ROS_LOG(ros::NodeHandle::INFO, "msg")`
--- 

1. **ROS_INFO：** 用于打印一般消息。
```cpp
ROS_INFO("This is a general information message");
```
2. **ROS_WARN：** 用于打印警告消息。
```cpp
ROS_WARN("This is a warning message");
```
3. **ROS_ERROR：** 用于打印错误消息。
```cpp
ROS_ERROR("This is an error message");
```
4. **ROS_DEBUG：** 用于打印调试消息，需要设置 ROS 参数 `~rosdebug` 为 true 才会被输出。
```cpp
ROS_DEBUG("This is a debug message");
```
5. **ROS_FATAL：** 用于打印严重错误消息，通常表示程序无法继续执行。
```cpp
ROS_FATAL("This is a fatal error message");
```
--- 

6. **ROS_INFO_STREAM：** 使用流插入运算符（`<<`）构建消息的方式打印一般信息消息。
```cpp
int x = 42;
ROS_INFO_STREAM("The value of x is: " << x);
```
7. **ROS_WARN_STREAM：** 使用流插入运算符（`<<`）构建消息的方式打印警告消息。
```cpp
int y = 100;
ROS_WARN_STREAM("The value of y is: " << y);
```
8. **ROS_ERROR_STREAM：** 使用流插入运算符（`<<`）构建消息的方式打印错误消息。
```cpp
int z = -1;
ROS_ERROR_STREAM("Invalid value: " << z);
```
9. **ROS_DEBUG_STREAM：** 使用流插入运算符（`<<`）构建消息的方式打印调试消息。
```cpp
int debug_value = 123;
ROS_DEBUG_STREAM("Debug value: " << debug_value);
```
10. **ROS_FATAL_STREAM：** 使用流插入运算符（`<<`）构建消息的方式打印严重错误消息。
```cpp
int fatal_value = -456;
ROS_FATAL_STREAM("Fatal error: " << fatal_value);
```
---

11. **ROS_INFO_ONCE、ROS_WARN_ONCE、ROS_ERROR_ONCE、ROS_DEBUG_ONCE：** 只输出消息一次的版本。
```cpp
ROS_INFO_ONCE("This message will only be printed once");
```
--- 

12. **ROS_LOG：** 允许指定日志级别和消息内容。
```cpp
ROS_LOG(ros::NodeHandle::INFO, "This is a dynamic log message with INFO level");
```
---

13. **ROS_INFO_COND、ROS_WARN_COND、ROS_ERROR_COND、ROS_DEBUG_COND：** 在条件满足时才输出消息的版本。
```cpp
int condition = 1;
ROS_INFO_COND(condition > 0, "Condition is true");
```
