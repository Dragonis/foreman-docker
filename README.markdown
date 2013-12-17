Foreman Docker repository
=========================

There are two kinds of Foreman images available for consumption right now:

* lzap/fedora-foreman-git-stable - "development" setup
* lzap/fedora-foreman-prod-stable - "production" setup

The first one offers installation from sources (from git) using Rubygems. It
is running Rails in Webrick (PRODUCTION mode) with SQLite3. It is possible to
attach to Docker console (-t) to see the logs.

The latter is meant for production use case - it contains full pre-configured
installation of Foreman web application. During startup, certificates are
regenerated using the correct hostname provided. Note these images do not
contain smart-proxy, Docker containers are lightweight and for only one
process.

Both are using Fedora 19 as a backend image.

Starting up development setup
-----------------------------

    docker run -p 3333:3000 -i -t lzap/fedora-foreman-git-stable:1.3.1

You should see webrick running on the foreground now, visit
http://localhost:3333 (admin/changeme) and to stop the server use ctrl+c. Note
that this kind of setup is not for production use, for this reason Foreman web
app spawns in the foreground. Please ignore the fact that Rails stack is
running under "production" setup, there is no point of running in
"development" mode since it is not possible to edit files in a running
container.

If you do not provide `-i -t` options, ctrl-c will not work and therefore you
need to kill the process using `ps` and `kill` docker commands.

    docker ps
    docker kill container_id

Starting up production setup
----------------------------

This setup can be used for production as it is was installed using our
official installer (foreman-installer) and content is being served by apache2
httpd daemon (through passenger).

TBD

Building images
---------------

First of all we need to build "base" image that contains all necessary
requirements for setup. All versions are based on this image, thus much
smaller.

    pushd fedora-foreman-stable-git
    docker build -t YOURNAME/fedora-foreman-git-base:f19 .
    popd

Now we want to build Foreman on top of that image. Before running that, check
the version defined in the Dockerfile (e.g. 1.3.1) and use the very same image
tag.

    pushd fedora-foreman-git-stable
    vim Dockerfile
    docker build -t YOURNAME/fedora-foreman-git-stable:1.3.1 .
    docker push YOURNAME/fedora-foreman-git-stable
    popd

Getting shell
-------------

If you want to get a shell to investigate the environment, do something like:

    docker run -p 3333:3000 -i -entrypoint='/bin/bash' -t lzap/fedora-foreman-stable-XYZ

TODO
----

* Push "latest" tags for all repos
* Setup automated build via Github and Index building service
* Create new fedora-foreman-production puppetized setup (need to resolve hostname issue)

