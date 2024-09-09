#!/bin/bash
source devel/setup.bash
roslaunch grid_path_searcher demo.launch &
rosbag play pointCloudMap.bag