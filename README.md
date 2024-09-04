# ros_docker

This repository contains the Dockerfile and scripts to run ROS 2 Jazzy and Gazebo Harmonic within a docker container.

## Setup

To use this project first create a `.env` file with the ROS workspace (`ROS_WS`) specified, for example:

```sh
ROS_WS=/home/$USER/ros_docker/ros2_ws
```

## Building and running

To build this Dockerfile:

```sh
./build.sh
```

To run this Dockerfile:

```sh
./run.sh
```

## Other

If the docker container doesn't shut down properly then run:

```sh
./remove.sh
```
