# Mocha

## The world's worst static site generator

Learning how to configure hugo was boring, so I just hacked together a couple of scripts to turn a bunch of markdown into something bloggish.
You probably shouldn't use this.

If you do somehow think this is your best option but are too lazy to read the source code, here's how to use it:

## Prerequisites

- pandoc
- a web server

## Usage

- Content goes in `posts/` Each article should go in a separate file with a name ending in `.md`.
- Run `$ ./build`.
- Copy the `site/` directory to the root of your webserver.
- That's it.

