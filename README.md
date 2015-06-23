# reactjs_server-side-rendering_with_perl

React.js server-side rendering example on Perl web server.

## Requirements

- Perl
- Node.js
- SQLite
- libv8 (v.3.14.5.8)

## Setup

``` console
$ git clone git@github.com:zoncoen-sample/reactjs_server-side-rendering_with_perl.git
$ cd reactjs_server-side-rendering_with_perl
$ npm run setup
$ npm start
```

## How to try server-side rendering

- `http://localhost:5000/`: only client-side rendering
- `http://localhost:5000/?prerender`: enable server-side rendering
