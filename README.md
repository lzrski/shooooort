Shooooort Frontend
==================

A frontend for the URL shortener with a long name.

[Live demo][]

This is mainly an exercise in [Redux][], [Fetch API][], [Local Storage][] and [Flexbox][]. Please do not take it too seriously :)

Build
-----

All you need is [Git][] and [Node.js][] installed.

```bash
git clone https://github.com/lzrski/shooooort-frontend.git
cd shooooort-frontend
npm install
NODE_ENV=staging npm run prepublish
```

This will produce static files in `build/frontend` directory to be served by your favorite HTTP server. If you just want to see it running in your browser, then try:

```bash
NODE_ENV=staging npm run develop
```

See [Develop section](#develop) below for more info.

Use
---

Type or paste the URL in input box and press `enter` or use 'Shorten this link' button.

Shortened URLs are shown in a table below. Clicking on any of them should copy the URL to your system clipboard. You can also use `tab` key to navigate and `enter` to copy.

Develop
-------

There is also a dedicated script for running this application in development mode: `npm run develop`. This will build, run tests, watch and serve the app in live reload mode on http://localhost:8000/. The browser window should open automatically.

```bash
NODE_ENV=staging npm run develop
```

> NOTE: Setting `NODE_ENV` variable is required if you do not run local proxy for the API server. The original backend (at http://gymia-shorty.herokuapp.com/) doesn't set CORS headers, so fetching data directly from it wouldn't work in modern browsers. To bypass this issue there is a publicly accessible reverse proxy that adds this headers at http://api.shooooort.lazurski.pl/. By setting `NODE_ENV` to 'staging' you will instruct the build system to use this proxy.
>
> Alternatively you can run local proxy at port 8080, e.g. using docker and docker-copose: `docker-copose up web`. Then please set `NODE_ENV` to `development`.
>
> If you need to change the address then you need to look into [`Gulpfile`](./gulpfile.coffee) (`config` task).


[Live demo]:      http://shooooort.lazurski.pl/
[Redux]:          http://gymia-shorty.herokuapp.com/6ac3c3
[Fetch API]:      http://gymia-shorty.herokuapp.com/6a94
[Local Storage]:  http://gymia-shorty.herokuapp.com/10e31
[Flexbox]:        http://gymia-shorty.herokuapp.com/03ba7
[Git]:            http://gymia-shorty.herokuapp.com/796d94
[Node.js]:        http://gymia-shorty.herokuapp.com/dbda4a
