# wstest

The Faye WebSocket stack consists of these modules:

* faye-websocket: [node](https://github.com/faye/faye-websocket-node),
  [ruby](https://github.com/faye/faye-websocket-ruby)
* websocket-driver: [node](https://github.com/faye/websocket-driver-node),
  [ruby](https://github.com/faye/websocket-driver-ruby)
* websocket-extensions:
  [node](https://github.com/faye/websocket-extensions-node),
  [ruby](https://github.com/faye/websocket-extensions-ruby)
* permessage-deflate: [node](https://github.com/faye/permessage-deflate-node),
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

```
git clone git://github.com/faye/wstest.git
cd wstest
virtualenv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

To update all the WebSocket modules from source and set up their dependencies:

```
./script/update-code
```

To run the server tests:

```
./script/node-servers
./script/ruby-servers
wstest -m fuzzingclient
killall node ruby java
```

To run the client tests:

```
wstest -m fuzzingserver &
./script/run-clients
```
