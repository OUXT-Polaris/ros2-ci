ARG ROS2_DISTRO
ARG IMAGE_NAME

FROM ${IMAGE_NAME}:${ROS2_DISTRO}

ENV DEBIAN_FRONTEND=noninteractive

#RUN apt-get update &&
#    apt-get install -y  -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" keyboard-configuration

ARG ROS2_DISTRO
ENV ROS2_DISTRO=${ROS2_DISTRO}

COPY ws /ws

COPY entrypoint.bash /bin/entrypoint.bash
RUN chmod +x /bin/entrypoint.bash

RUN apt-get update && apt-get install -y curl git python3-pip wget

ENTRYPOINT ["entrypoint.bash"]
