FROM mattdm/fedora
RUN hostname foreman.docker.io
RUN sed -i "s/^127.0.0.1/127.0.0.1 $(hostname) /" /etc/hosts
RUN yum -y install http://yum.theforeman.org/releases/1.3/f19/x86_64/foreman-release.rpm
RUN yum -y install foreman-installer
RUN foreman-installer --no-enable-foreman --no-enable-puppet --no-enable-foreman-proxy
RUN yum clean all
EXPOSE 80
EXPOSE 443
#CMD ["/usr/bin/systemctl", "start", "httpd"]
