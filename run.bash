xhost +local:docker

source .env

docker run --name ros_docker_container -it --net=host \
  --env="DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --workdir="/home/ros2_ws" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="$ROS_WS:/home/ros2_ws:rw" \
  ros_docker bash
