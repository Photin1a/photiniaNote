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
auto pi = j.at("pi").get<double>();  //method1 推荐
j.at("pi").get_to(pi);//method2
```
## 2.3 文件流操作
```cpp
std::ofstream file("pretty.json");
file << json << std::endl;
file.close();
```
## 2.4 序列化、反序列化
```cpp
std::string str = '{"a":1}';
//case1: string to json
json js = json::parse(str.c_str());

//case2: json to string
std::string str = js.dump();

//case3: cin cout
json j;
std::cin >> j; // 从标准输入中反序列化json对象
std::cout << j; // 将json对象序列化到标准输出中

//case4: ifstream, ofstream
std::ifstream is("file.json");
json j;
is >> j;

std::ofstream os("pretty.json");
os  << j << std::endl;
```

## 2.5 任意类型转换
只需要在结构体所在的命名空间下定义 `void to_json(json& j, const Typename &p)`和`void from_json(const json& j, Typename &p)`,就可以使用自定义类型转换了
* 在`from_json`中要使用`at()`，因为当你读取不存在的名称时，它会抛出错误。
```cpp
using nlohmann::json;

namespace ns {
    struct person {
        std::string name;
        std::string address;
        int age;
    };

    void to_json(json& j, const person& p) {
        j = json{{"name", p.name}, {"address", p.address}, {"age", p.age}};
    }

    void from_json(const json& j, person& p) {
        j.at("name").get_to(p.name);
        j.at("address").get_to(p.address);
        j.at("age").get_to(p.age);
    }
} // namespace ns

ns::person p {"Ned Flanders", "744 Evergreen Terrace", 60};
json j = p;
std::cout << j << std::endl;
// {"address":"744 Evergreen Terrace","age":60,"name":"Ned Flanders"}

// conversion: json -> person
auto p2 = j.get<ns::person>();

// that's it
assert(p == p2);

```

>https://blog.csdn.net/Dontla/article/details/130885229
>https://www.cnblogs.com/linuxAndMcu/p/14503341.html