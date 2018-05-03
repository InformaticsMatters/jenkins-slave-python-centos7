# A Dockerfile to build an OpenShift Jenkins Slave Agent.
# It's based on the OpenShift Base image and provides Python 2.

# The v3.7 digest...
FROM openshift/jenkins-slave-base-centos7@sha256:3059d49e6666c0bc6198d20e956a5b03589bab6e06e26906c19c64ed55922754
MAINTAINER Alan Christie (alanbchristie)

# Install gcc
RUN yum -y group install "Development Tools"

# Install Python and the latest setup tools
RUN yum -y --enablerepo=extras install epel-release
RUN yum -y install \
    python-devel.x86_64 \
    python-pip
RUN pip install --upgrade pip
RUN pip install setuptools==39.1.0

# Adjust path for ''--user' use of pip
# where stuff gets installed in ${HOME}/.local/bin
ENV PATH ${PATH}:/home/jenkins/.local/bin

# To fix the error: -
#       UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3
#                in position 3516: ordinal not in range(128)
# Seen when trying to install pyroma v2.3.
# We ned to set `LC_ALL` and allow utc-8.
ENV LC_ALL=en_US.UTF-8

WORKDIR ${HOME}
