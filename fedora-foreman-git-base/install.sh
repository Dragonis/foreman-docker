#!/bin/bash
#
# Prepares Fedora base-image (with all dependencies required)
#

yum -y install gcc-c++ git ruby ruby-devel rubygems \
  libvirt-devel mysql-devel postgresql-devel openssl-devel \
  libxml2-devel sqlite-devel libxslt-devel zlib-devel \
  readline-devel

yum clean all
