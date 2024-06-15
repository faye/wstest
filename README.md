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
black-box test suite for WebSocket servers and clients. The Autobahn test suite
is a Python 2 application and can be tricky to get running; the configuration
here is intended to give the best chance of getting everything installed
correctly.

To get started, clone this repository and `cd` into the clone.

    $ git clone https://github.com/faye/wstest.git
    $ cd wstest

You will need an Ubuntu machine to install all the dependencies and run the
tests. Specifically, Ubuntu 20.04 is required for all the Python dependencies to
install correctly.

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

These scripts may update the shell configuration, so you should exit and
re-enter the VM after running them to reload the shell:

    $ exit
    $ multipass shell wsvm
    $ cd wstest

Next, you need to download all the code for the Faye packages and install their
dependencies, by running this script:

    $ ./scripts/update-code

If everything completed successfully you should now be able to run the tests
themselves. To run the client tests, start the `wstest` server and then run the
client test script:

    $ wstest -m fuzzingserver
    $ ./scripts/clients

To run the server tests, you first need to start all the Node and Ruby servers
running:

    $ ./scripts/node-servers
    $ ./scripts/ruby-servers

Once the servers are all started, run the `wstest` client:

    $ wstest -m fuzzingclient

Once this has completed you can stop all the servers by killing them all:

    $ killall node ruby java
