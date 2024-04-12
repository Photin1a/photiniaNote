# 一、简介
#开源的、跨平台的、仅仅header头文件的json操作库。
```cpp
#include "nlohmann/json.hpp"
using json = nlohmann::json;
```
## 二、使用
## 2.1 构建json对象
```json
{
  "pi": 3.141,
  "happy": true,
  "name": "Niels",
  "nothing": null,
  "answer": {
    	"everything": 42
  },
  "list": [1, 0, 2],
  "object": {
	    "currency": "USD",
 	    "value": 42.99
  }
}
```

```cpp
json j; // 首先创建一个空的json对象
j["pi"] = 3.141;
j["happy"] = true;
j["name"] = "Niels";
j["nothing"] = nullptr;
j["answer"]["everything"] = 42; // 初始化answer对象
j["list"] = { 1, 0, 2 }; // 使用列表初始化的方法对"list"数组初始化
j["object"] = { {"currency", "USD"}, {"value", 42.99} }; // 初始化object对象
```
## 2.2 获取json
```cpp
//方法1    不建议使用，因为当元素不存在时，[]会返回一个新的`null`json值，可能会引发潜在的错误。
double pi = j["pi"];  

//方法2    使用at()获取元素，元素不存在时，它将抛出一个异常 out_of_range
double pi = j.at("pi");   
double arr = j.at("list").at(1); //数组用at(idx)
try {
    auto element = j.at("nonexistent");
} catch(const std::out_of_range& e) {
    std::cout << "Element not found: " << e.what() << std::endl;
}


//方法3 get显示类型转换  建议使用
auto pi = j.at("pi").get<double>();

```
## 2.3 文件流操作
```cpp
std::ofstream file("pretty.json");
file << json << std::endl;
file.close();
```
## 2.4 序列化、反序列化
```cpp
json js;

//
```


>https://blog.csdn.net/Dontla/article/details/130885229
>https://www.cnblogs.com/linuxAndMcu/p/14503341.html