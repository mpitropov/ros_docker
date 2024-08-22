xhost +local:docker

docker run --name robotdocker_container -it --net=host \
  --env="DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="/home/matthew/Projects/robot/packages:/home/packages:rw" \
  robotdocker bash
