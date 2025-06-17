# wstest

The Faye WebSocket stack consists of these modules:

- faye-websocket: [node](https://github.com/faye/faye-websocket-node),
  [ruby](https://github.com/faye/faye-websocket-ruby)
- websocket-driver: [node](https://github.com/faye/websocket-driver-node),
  [ruby](https://github.com/faye/websocket-driver-ruby)
- websocket-extensions:
  [node](https://github.com/faye/websocket-extensions-node),
  [ruby](https://github.com/faye/websocket-extensions-ruby)
- permessage-deflate: [node](https://github.com/faye/permessage-deflate-node),
  [ruby](https://github.com/faye/permessage-deflate-ruby)

These are all tested using
[Autobahn](https://github.com/crossbario/autobahn-testsuite), an exhaustive
black-box test suite for WebSocket servers and clients.

To get started, clone this repository and `cd` into the clone.

    $ git clone https://github.com/faye/wstest.git
    $ cd wstest


## Building the environment

To get a working test environment we provide a number of options. Because it is
somewhat hard and time consuming to get everything installed correctly, we
provide a pre-built Docker image that contains everything you need. Or if you
prefer, you can use the included scripts to build the environment yourself.

### Use an existing Docker image

To use our existing Docker image, run the following command to launch it as a
container. Bear in mind the image is quite large and may take a long time to
download, but is still likely faster than building the image yourself.

    $ docker run -it --rm --name wsvm -v .:/wstest jcoglan/wstest:latest

This will open a shell on the container and the container will stop and delete
itself when you exit this shell. You can open more shells as needed on the
container using these commands; make sure to enter the `/wstest` directory in
each one.

    $ docker exec -it wsvm bash
    $ cd /wstest

### Build a fresh Docker image

If you would rather build the Docker image yourself, run this command:

    $ docker build -t wstest .

This uses the scripts in `./install` to set everything up and make take a long
time to run. Once the image is built, launch it as a container:

    $ docker run -it --rm --name wsvm -v .:/wstest wstest

Open further shells as needed on the same container using these commands:

    $ docker exec -it wsvm bash
    $ cd /wstest

### Build the environment yourself

The scripts in this repository can be used to build the environment yourself if
you don't want to use Docker. The Autobahn test suite is a Python 2 application
and has trouble installing on some recent operating systems, but it is known to
work on Ubuntu 20.04 and the Docker image is based on this.

You can get a VM from a cloud provider or use
[Multipass](https://multipass.run/) to set one up locally. Launch an instance
and mount the `wstest` directory into it.

    $ multipass launch 20.04 --name wsvm --disk 20G --memory 4G
    $ multipass mount . wsvm:wstest

Then, shell into the machine and navigate to the mounted `wstest` directory.

    $ multipass shell wsvm
    $ cd wstest

This repo contains scripts for installing everything needed to run the tests;
run them in the following order:

    $ ./install/autobahn
    $ ./install/node
    $ ./install/ruby

The scripts can also be used to install specific versions of Node or Ruby, after
they have been run for the first time:

    $ ./install/node 24
    $ ./install/ruby ruby 3.5.0
    $ ./install/ruby jruby 10.0.0.0

These scripts may update the shell configuration, so you should exit and
re-enter the VM after running them to reload the shell:

    $ exit
    $ multipass shell wsvm
    $ cd wstest


## Running the tests

Once you have a working environment, download all the code for the Faye packages
and install their dependencies, by running this script:

    $ ./scripts/update-code

If everything completed successfully you should now be able to run the tests. To
run the client tests, start the `wstest` server and then run the client test
script in a separate shell:

    # shell 1
    $ wstest -m fuzzingserver

    # shell 2
    $ ./scripts/clients

To run the server tests, you first need to start all the Node and Ruby servers
running:

    $ ./scripts/node-servers
    $ ./scripts/ruby-servers

Once the servers are all started, run the `wstest` client:

    $ wstest -m fuzzingclient

Once this has completed you can stop all the servers by killing them all:

    $ killall node ruby java
