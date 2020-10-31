# Example IPv6 HTTP Fano Web Application

Example web application skeleton using Fano Framework, Pascal web application framework, that demonstrates
how to setup HTTP web application which use [IPv6 address](https://fanoframework.github.io/working-with-application#use-ipv6-address).

This project is generated using [Fano CLI](https://github.com/fanoframework/fano-cli)
command line tools to help scaffolding web application using Fano Framework.

## Requirement

- Linux or FreeBSD
- [Free Pascal](https://www.freepascal.org/) >= 3.0
- [Fano CLI](https://github.com/fanoframework/fano-cli)
- libmicrohttpd
- Web server ([Apache with mod_proxy_http](https://httpd.apache.org/docs/current/mod/mod_proxy_http.html), nginx) as reverse proxy (optional)
- Administrative privilege for setting up virtual host

## Installation

Make sure all requirements are met. Run
```
$ git clone https://github.com/fanoframework/fano-mhdipv6.git --recursive
$ cd fano-mhdipv6
$ ./tools/config.setup.sh
$ ./build.sh
$ ./bin/app.cgi
```
Open internet browser and go to `http://[::1]:20477`. You should see application.

## Running behind reverse proxy
If you want to run application behind web server using reverse proxy, run

```
$ sudo fanocli --deploy-http=mhdipv6.fano --host="[::1]"
```

Edit `/etc/hosts` and add

```
::1 mhdipv6.fano
```

Open internet browser and go to `http://mhdipv6.fano`. You should see application.
