# A Dockerfile to build an OpenShift Jenkins Slave Agent.
# It's based on the OpenShift Base image.

# The v3.7 digest...
FROM openshift/jenkins-slave-base-centos7@sha256:3059d49e6666c0bc6198d20e956a5b03589bab6e06e26906c19c64ed55922754
MAINTAINER Alan Christie (alanbchristie)

RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y install \
    python36u \
    python36u-pip \
    python36u-devel

# We're root at this stage of the script.
# Return to the underlying user id (1001).
USER 1001
WORKDIR ${HOME}
