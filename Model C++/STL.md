### 1、优先级队列 std::priority_queue
其实`priority_queue`并不是一种基础的容器，而是一种调用别的容器的封装。
#### 原型
```cpp
template <class T, class Container = vector<T>,class Compare = less<typename Container::value_type> > 
class priority_queue;
- `T`：参数类型
- `Container`：容器类型。默认是用`vector`容器实现，参数类型必须是`T`
- `Compare`：排序规则。默认是小顶堆弹出`std::less<T>`
- `less<T>`变成大顶堆（从上层到下层，堆元素是从大到小，同层之间随便）  
- `greater<T>`变成小顶堆（从上层到下层，堆元素是从小到大，同层之间随便）

// 可以看到它的push操作就是调用别的容器的
void push(const value_type& __x)
{
	c.push_back(__x);
	std::push_heap(c.begin(), c.end(), comp);
}
```
```


```cpp
// 创建一个整数优先级队列，使用 lambda 表达式定义比较函数，创建最小堆
    std::priority_queue<int, std::vector<int>, std::greater<int>> pq;
```

#### 对于自定义的数据类型，必须在类型内部重载运算符，或者用lambda表达式
```cpp
struct Node
{
    // 要比较的元素
    int x;
    // 构造函数
    Node1(int x) { this->x = x; }
    // 操作符重载函数
    // 必须是具体的操作符>之类的  从大到小
    bool operator>(const Node &b) const
    {
        // 实现greater中需要的>,小顶堆
        return x > b.x;
    }
};

##c++20
auto less_compare  = [](T &last, T &sec){return last > sec?true:false; }; //降序规则
std::priority_queue<T, std::list<T>,decltype(less_compare) pq(less_compare); //降序排列
```