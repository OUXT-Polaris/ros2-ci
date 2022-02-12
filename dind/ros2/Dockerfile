ARG DOCKER_TAG
ARG DOCKER_IMAGE

FROM ${DOCKER_IMAGE}:${DOCKER_TAG}

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
