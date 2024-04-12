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
只需要在结构体所在的命名空间下定义 `void to_json(json& j, const Typename &p)`和`void from_json(const json& j, Typename &p)`,就可以使用自定义类型转换了。
**notes：**
* 函数`to_json()`和`from_json()`和你定义的数据类型在同一个命名空间中
* 使用时包含它所在的头文件
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
#ps *:当可以将任意类型数据方便的转换到 json，就可以将这个 json 方便的序列化到本地保存，也可以从本地反序列化到内存中，比自己去写每一个字节的操作方便多了。* 
## 2.6 转换JSON到二进制格式
## 2.7 从STL到JSON
* nlohmann 库支持从 STL 的任意序列容器初始化获得 json 对象（`std::array`, `std::vector`, `std::deque`, `std::forward_list`, `std::list`），它们的值可以被用来构造 json 的值。
* `std::set`, `std::multiset`, `std::unordered_set`, `std::unordered_multiset`关联容器也具有同样的用法，并且也会保存其内在的顺序。
* `std::map`, `std::multimap`, `std::unordered_map`, `std::unordered_multimap`，nlohmann 也支持，但是需要注意的是其中的 Key 被构造为 std::string 保存。
```cpp
std::vector<int> c_vector {1, 2, 3, 4};
json j_vec(c_vector);
// [1, 2, 3, 4]

std::deque<double> c_deque {1.2, 2.3, 3.4, 5.6};
json j_deque(c_deque);
// [1.2, 2.3, 3.4, 5.6]

std::list<bool> c_list {true, true, false, true};
json j_list(c_list);
// [true, true, false, true]

std::forward_list<int64_t> c_flist {12345678909876, 23456789098765, 34567890987654, 45678909876543};
json j_flist(c_flist);
// [12345678909876, 23456789098765, 34567890987654, 45678909876543]

std::array<unsigned long, 4> c_array {{1, 2, 3, 4}};
json j_array(c_array);
// [1, 2, 3, 4]

std::set<std::string> c_set {"one", "two", "three", "four", "one"};
json j_set(c_set); // only one entry for "one" is used
// ["four", "one", "three", "two"]

std::unordered_set<std::string> c_uset {"one", "two", "three", "four", "one"};
json j_uset(c_uset); // only one entry for "one" is used
// maybe ["two", "three", "four", "one"]

std::multiset<std::string> c_mset {"one", "two", "one", "four"};
json j_mset(c_mset); // both entries for "one" are used
// maybe ["one", "two", "one", "four"]

std::unordered_multiset<std::string> c_umset {"one", "two", "one", "four"};
json j_umset(c_umset); // both entries for "one" are used
// maybe ["one", "two", "one", "four"]

std::map<std::string, int> c_map { {"one", 1}, {"two", 2}, {"three", 3} };
json j_map(c_map);
// {"one": 1, "three": 3, "two": 2 }

std::unordered_map<const char*, double> c_umap { {"one", 1.2}, {"two", 2.3}, {"three", 3.4} };
json j_umap(c_umap);
// {"one": 1.2, "two": 2.3, "three": 3.4}

std::multimap<std::string, bool> c_mmap { {"one", true}, {"two", true}, {"three", false}, {"three", true} };
json j_mmap(c_mmap); // only one entry for key "three" is used
// maybe {"one": true, "two": true, "three": true}

std::unordered_multimap<std::string, bool> c_ummap { {"one", true}, {"two", true}, {"three", false}, {"three", true} };
json j_ummap(c_ummap); // only one entry for key "three" is used
// maybe {"one": true, "two": true, "three": true}

```
# 三、参考
>https://blog.csdn.net/Dontla/article/details/130885229
>https://www.cnblogs.com/linuxAndMcu/p/14503341.html