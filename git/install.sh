#!/bin/bash
#
# Installs Foreman from git using rubygems
#

VERSION=$1
# libvirt does not compile at the moment
WITHOUT="mysql mysql2 pg test libvirt"

# install deps
yum -y install gcc-c++ git ruby ruby-devel rubygems \
  libvirt-devel mysql-devel postgresql-devel openssl-devel \
  libxml2-devel sqlite-devel libxslt-devel zlib-devel \
  readline-devel

# checkout foreman
git clone https://github.com/theforeman/foreman.git -b $VERSION --depth 1

# compile deps and migrate db
pushd foreman
cp config/settings.yaml.example config/settings.yaml
cp config/database.yml.example config/database.yml
gem install bundler
echo "gem 'facter'" > bundler.d/Gemfile.local.rb
# TEMPORARY FIX - should be fixed in 1.3.2+
echo "gem 'locale', '<= 2.0.9'" >> bundler.d/Gemfile.local.rb
bundle install --without $WITHOUT --path vendor
FACTER_domain=lan FACTER_fqdn=$(hostname).lan RAILS_ENV=production bundle exec rake db:migrate assets:precompile locale:pack
popd

# cleanup image
yum clean all
