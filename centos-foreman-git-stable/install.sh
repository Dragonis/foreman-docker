#!/bin/bash
yum -y install http://yum.theforeman.org/releases/1.6/el6/x86_64/foreman-release.rpm \
  http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum -y install foreman-installer
# we must not deploy any files or certs that are hostname/fqdn based
rm -f /usr/share/foreman-installer/checks/hostname.rb
#hostname $(hostname).uninstalled
export FACTER_fqdn=$(hostname)
foreman-installer --no-enable-foreman --no-enable-puppet --no-enable-foreman-proxy
yum clean all
