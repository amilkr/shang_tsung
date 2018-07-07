![shang-tsung](priv/static/images/logo.png)

# ShangTsung

_A DSL and web wrapper for [Tsung](http://tsung.erlang-projects.org/user_manual/introduction.html)_

## Introduction

TODO

## Try it yourself

Shang Tsung is a phoenix application (I'm considering removing Phoenix and keeping only Plug). To get it running in your dev machine, you have to follow the regular steps to run phoenix apps.

The only special consideration is that Shang Tsung needs an specific node name in order to keep running 
after Tsung finishes the load test: `tsung_controller@...`.

```
$ git clone git@github.com:amilkr/shang-tsung.git
$ cd shang-tsung
$ mix deps.get
$ cd assets && npm install && cd -
$ iex --name "tsung_controller@127.0.0.1" -S mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

