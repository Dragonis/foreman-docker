FROM centos:centos6
MAINTAINER Lukas Zapletal <lzap+rpm@redhat.com>
ADD ./install.sh /opt/install.sh
ADD ./start.sh /opt/start.sh
RUN cd /opt && bash -x install.sh
EXPOSE 3000
ENTRYPOINT cd /opt && bash start.sh
