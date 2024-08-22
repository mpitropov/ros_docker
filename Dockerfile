FROM ubuntu:22.04
# Don't install extra dependencies
RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
# Update and ignore prompts
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update

# https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html
# ROS requires locale with UTF-8 support
# RUN DEBIAN_FRONTEND=noninteractive \
#   apt-get install apt-utils \
#   && apt-get install locales \
#   && locale-gen en_US en_US.UTF-8 \
#   && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
#   && export LANG=en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive \
  apt install -y software-properties-common \
  && add-apt-repository universe

RUN DEBIAN_FRONTEND=noninteractive \
  apt update && apt install -y curl \
  && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN DEBIAN_FRONTEND=noninteractive \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Update and ignore prompts
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && apt-get upgrade

RUN DEBIAN_FRONTEND=noninteractive \
  apt install -y ros-iron-desktop

# Gazebo requirements
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y lsb-release wget gnupg

# Install of Gazebo Harmonic
RUN DEBIAN_FRONTEND=noninteractive \
  wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null \
  && apt-get update \
  && apt-get install -y gz-harmonic

# Clear apt lists now that we installed everything
RUN DEBIAN_FRONTEND=noninteractive \
  && rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/iron/setup.bash" >> ~/.bashrc
