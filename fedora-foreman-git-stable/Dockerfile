FROM lzap/fedora-foreman-git-base:f19
MAINTAINER Lukas Zapletal <lzap+rpm@redhat.com>
ADD ./install.sh /opt/install.sh
ADD ./start.sh /opt/start.sh
RUN cd /opt && bash install.sh 1.3.1
EXPOSE 3000
ENTRYPOINT cd /opt && bash start.sh
