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

These are all tested using [Autobahn](http://autobahn.ws/testsuite/), an
exhaustive black-box test suite for WebSocket servers and clients.

This repo contains everything we use to run the test suite for all the
combinations of languages, versions and app servers we support. It is very much
in a "works on my machines" state, and assumes you have
[nvm](https://github.com/creationix/nvm) and
[chruby](https://github.com/postmodern/chruby) installed in the canonical
locations, and that you have all the required Node and Ruby versions installed.

To get set up:

    git clone git://github.com/faye/wstest.git
    cd wstest
    pipenv install

To update all the WebSocket modules from source and set up their dependencies:

    ./scripts/update-code

To run the server tests, first start up the test servers:

    ./scripts/node-servers
    ./scripts/ruby-servers

Then, in a pipenv shell, run the wstest client:

    pipenv shell
    wstest -m fuzzingclient

Once the tests are complete, shut down all the test servers:

    killall node ruby java

To run the client tests, start the wstest server in a pipenv shell:

    pipenv shell
    wstest -m fuzzingserver

Then, run the test clients:

    ./scripts/clients
