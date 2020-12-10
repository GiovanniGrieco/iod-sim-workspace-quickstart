#!/usr/bin/bash

set -x

ARCHIVE_NAME=iod-sim-exe.tgz
USER_UID=1000
USER_DIR=$(getent passwd $USER_UID | cut -d ':' -f 6)
USER_NAME=$(getent passwd 1000 | cut -d ':' -f 1)
DEBIAN_FRONTEND=noninteractive

# Use APT with official repos
bash -c "cat > /etc/apt/sources.list <<EOF
deb http://archive.ubuntu.com/ubuntu/ focal main restricted
deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted
deb http://archive.ubuntu.com/ubuntu/ focal universe
deb http://archive.ubuntu.com/ubuntu/ focal-updates universe
deb http://archive.ubuntu.com/ubuntu/ focal multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-updates multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu/ focal-security main restricted
deb http://security.ubuntu.com/ubuntu/ focal-security universe
deb http://security.ubuntu.com/ubuntu/ focal-security multiverse
EOF"

echo 'nameserver 1.1.1.1' >> /etc/resolv.conf

apt update
apt upgrade -y

# Use APT with official repos
bash -c "cat > /etc/apt/sources.list <<EOF
deb http://archive.ubuntu.com/ubuntu/ focal main restricted
deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted
deb http://archive.ubuntu.com/ubuntu/ focal universe
deb http://archive.ubuntu.com/ubuntu/ focal-updates universe
deb http://archive.ubuntu.com/ubuntu/ focal multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-updates multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu/ focal-security main restricted
deb http://security.ubuntu.com/ubuntu/ focal-security universe
deb http://security.ubuntu.com/ubuntu/ focal-security multiverse
EOF"

echo 'nameserver 1.1.1.1' >> /etc/resolv.conf

apt update
apt remove -y \
    snapd
apt install -y --no-install-recommends \
    gdb \
    gsl-bin \
    libgsl23 \
    libgslcblas0 \
    libxml2
apt autoremove -y

wget --directory-prefix ${USER_DIR}/ https://telematics.poliba.it/images/file/boccadoro/${ARCHIVE_NAME}
tar -C ${USER_DIR}/ -xvzf ${USER_DIR}/${ARCHIVE_NAME}
echo "export LD_LIBRARY_PATH=/home/${USER_NAME}/iod-sim-exe/lib/" >> /${USER_DIR}/.bashrc
mkdir ${USER_DIR}/results

chown $USER_UID:$USER_UID -R ${USER_DIR}/
