#!/bin/sh

ROS2_DISTRO="${1}"
APT_PACKAGES="${2}"
PIP_PACKAGES="${3}"
EXTERNAL_REPOS="${4}"
PRE_INSTALL="${5}"
POST_INSTALL="${6}"
PRE_BUILD="${7}"
POST_BUILD="${8}"
PRE_TEST="${9}"
POST_TEST="${10}"
REPOS_FILEPATH="${11}"
IMAGE_NAME="${12:-wamvtan/ros2-ci-base}"


echo ''
echo '======== Running the Docker daemon ========'
echo ''

dockerd-entrypoint.sh &
sleep 10

mkdir -p "/ros2/ws/src" && cp -r "${GITHUB_WORKSPACE}" "/ros2/ws/src/packages" || exit $?

echo ''
echo '======== Building the ROS 2 image ========'
echo ''


docker build \
  --build-arg ROS2_DISTRO="${ROS2_DISTRO}" \
  --build-arg IMAGE_NAME="${IMAGE_NAME}" \
  -t ros2-ci:latest /ros2 || exit $?

echo ''
echo '======== Running the ROS 2 container ========'
echo ''

docker run \
  --env APT_PACKAGES="${APT_PACKAGES}" \
  --env PIP_PACKAGES="${PIP_PACKAGES}" \
  --env EXTERNAL_REPOS="${EXTERNAL_REPOS}" \
  --env PRE_INSTALL="${PRE_INSTALL}" \
  --env POST_INSTALL="${POST_INSTALL}" \
  --env PRE_BUILD="${PRE_BUILD}" \
  --env POST_BUILD="${POST_BUILD}" \
  --env PRE_TEST="${PRE_TEST}" \
  --env POST_TEST="${POST_TEST}" \
  --env REPOS_FILEPATH="${REPOS_FILEPATH}" \
  --rm ros2-ci:latest || exit $?
