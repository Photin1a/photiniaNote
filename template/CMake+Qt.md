```sh
git clone https://github.com/Photin1a/cmake_qt_template.git
```
### step1：保证工程目录如下
![[Pasted image 20240306124331.png]]
### step2：修改CMakeLists.txt文件
```cmake
cmake_minimum_required(VERSION 3.5)
project(calibration VERSION 0.1 LANGUAGES CXX)
set(CMAKE_BUILD_TYPE Debug)

#打开UIC，自动将ui文件转换为.h文件
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include)
include_directories(plugin)
# FILE(GLOB PROJECT_HEADERS "include/*.h")

####################################TODO package#######################################
#3rd package
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

#指明Qt库的位置 如果环境变量有Qt，就可以不用
list(APPEND CMAKE_PREFIX_PATH "/opt/Qt/5.15.2/gcc_64")
find_package(Qt5 REQUIRED COMPONENTS Widgets Core Charts Network)
#include_directories

####################################TODO project files#######################################
#headers
list(APPEND PROJECT_HEADERS
# include/mainwindow.h
# plugin/plugin_A/plugin_A.h
)

#sources
list(APPEND PROJECT_SOURCES
src/main.cpp
)

#ui_dir
list(APPEND UI_FILES_PATHS
ui/
)

# resource files qrc
list(APPEND RESOURCE_QRC
resources/res.qrc
)

####################################TODO plugin files#######################################
# #libplugin_A.so
# set(PLUGIN_NAME plugin_A)#setup.1
# set(PLUGIN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/plugin/plugin_A) #设置plugin_A目录 setup.2
# set(PLUGIN_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/plugin/plugin_A) #设置plugin_A输出目录 setup.3
# configure_file(${PLUGIN_DIR}/plugin_A_base_class.json ${PLUGIN_OUTPUT_DIR}/plugin_A_base_class.json COPYONLY)# copy json file to OUTPUT_DIR setup.4
# add_library(${PLUGIN_NAME} SHARED
# ${PLUGIN_DIR}/plugin_A.cpp
# ${PLUGIN_DIR}/plugin_A.h #头文件也要放进来一起编译，不然运行时会报错
# )
# set_target_properties(${PLUGIN_NAME} PROPERTIES
# LIBRARY_OUTPUT_DIRECTORY ${PLUGIN_DIR}
# )
# target_link_libraries(${PLUGIN_NAME} PRIVATE
# Qt5::Core
# )

# #libplugin_B.so
# set(PLUGIN_NAME plugin_B)#setup.1
# set(PLUGIN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/plugin/plugin_B) #设置plugin_A目录 setup.2
# set(PLUGIN_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/plugin/plugin_B) #设置plugin_A输出目录 setup.3
# configure_file(${PLUGIN_DIR}/plugin_B_base_class.json ${PLUGIN_OUTPUT_DIR}/plugin_B_base_class.json COPYONLY)# copy json file to OUTPUT_DIR setup.4
# add_library(${PLUGIN_NAME} SHARED
# ${PLUGIN_DIR}/plugin_B.cpp
# ${PLUGIN_DIR}/plugin_B.h #头文件也要放进来一起编译，不然运行时会报错
# )
# set_target_properties(${PLUGIN_NAME} PROPERTIES
# LIBRARY_OUTPUT_DIRECTORY ${PLUGIN_DIR}
# )
# target_link_libraries(${PLUGIN_NAME} PRIVATE
# Qt5::Core
# )

####################################TODO executable files, librares files#######################################
add_executable(calibration
${PROJECT_HEADERS}
${PROJECT_SOURCES}
${RESOURCE_QRC}
)
set_property(TARGET calibration PROPERTY AUTOUIC_SEARCH_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/${UI_FILES_PATHS}) #根据CMAKE官方文档，CMAKE会去包含ui_.h的文件所在文件夹寻找.ui文件，或者去AUTOUIC_SEARCH_PATHS下寻找。
target_link_libraries(calibration PRIVATE
Qt5::Core
Qt5::Network
)
```
### 3、插件模板
```cpp
#ifndef BASE_LOCAL_PLANNER_H
#define BASE_LOCAL_PLANNER_H

#include <QString>
#include <QtPlugin>

#define PLUGIN_IID                                                             \
  "com.photinia.navigation.BaseLocalPlanner" //版本号必须有，或者json文件指定
#define PLUGIN_JSON "pid_controller_plugin/base_local_planner.json"
/**
 * @class BaseLocalPlanner
 * @brief Provides an interface for local planners used in navigation. All local
 * planners written as plugins for the navigation stack must adhere to this
 * interface.
 */
class BaseLocalPlanner {
public:
  /**
   * @brief  Given the current position, orientation, and velocity of the robot,
   * compute velocity commands to send to the base
   * @param cmd_vel Will be filled with the velocity command to be passed to the
   * robot base
   * @return True if a valid velocity command was found, false otherwise
   */
  virtual bool ComputeVelocityCommands(geometry_msgs::Twist &cmd_vel) = 0;

  /**
   * @brief  Check if the goal pose has been achieved by the local planner
   * @return True if achieved, false otherwise
   */
  virtual bool IsGoalReached() = 0;

  /**
   * @brief  Set the plan that the local planner is following
   * @param plan The plan to pass to the local planner
   * @return True if the plan was updated successfully, false otherwise
   */
  virtual bool SetPlan(const std::vector<geometry_msgs::PoseStamped> &plan) = 0;

  /**
   * @brief  Constructs the local planner
   * @param name The name to give this instance of the local planner
   * @param tf A pointer to a transform listener
   * @param costmap_ros The cost map to use for assigning costs to local plans
   */
  virtual void Initialize(const QString &name, const QString &config_file) = 0;
  virtual bool LoadConfig() = 0;
  virtual bool SaveConfig() = 0;
  virtual void SetParameter() = 0;

  /**
   * @brief  Virtual destructor for the interface
   */
  virtual ~BaseLocalPlanner() {}

  const void *params_;  //用于指向子类参数
};
Q_DECLARE_INTERFACE(BaseLocalPlanner, PLUGIN_IID)

#endif
```

```cpp
#ifndef PID_CONTROLLER_H
#define PID_CONTROLLER_H

#include "base_local_planner.h"
#include <QApplication>
#include <QFile>
#include <QObject>
#include <iostream>

class PIDController : public QObject, BaseLocalPlanner {
  Q_OBJECT
  Q_PLUGIN_METADATA(IID PLUGIN_IID FILE PLUGIN_JSON)
  Q_INTERFACES(BaseLocalPlanner)
public:
  bool ComputeVelocityCommands(geometry_msgs::Twist &cmd_vel) override;
  bool IsGoalReached() override;

  bool
  SetPlan(const std::vector<geometry_msgs::PoseStamped> &global_plan) override;
  void Initialize(const QString &name,
                  const QString &config_file_path) override; //在这里指向参数
  bool LoadConfig() override;
  bool SaveConfig() override;
  void SetParameter() override;

  ~PIDController();

private:
  struct PIDParams
      pid_controller_params_; //外部访问修改，通过父类参数指针指向调用
};

#endif
```