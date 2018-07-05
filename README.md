![shang-tsung](priv/static/images/logo.png)

# ShangTsung

_A DSL and web wrapper for Tsung_

## Introduction

TODO

## Try it yourself

Shang Tsung is a phoenix application (I'm considering removing Phoenix and keeping only Plug). To get it running in your dev machine, you have to follow the regular steps to run phoenix apps.

The only special consideration is that Shang Tsung needs a proper node name in order to be able to start Tsung nodes (using the [slave](http://www.erlang.org/doc/man/slave.html) module).

```
$ git clone git@github.com:amilkr/shang-tsung.git
$ cd shang-tsung
$ mix deps.get
$ cd assets && npm install && cd -
$ iex --name "shang-tsung@127.0.0.1" -S mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

