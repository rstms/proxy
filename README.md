test-proxy
----------

configures a remote nginx server to forward incoming connections to an nginx server running in a local container

Example docker-compose script that runs two containers: 
 - a local nginx web server serving a minimal hello world page.
 - an alpine-based proxy using ssh to connect to a remote nginx server

Port-forwarding is used to listen on localhost:remote_port on the remote server, and the remote nginx is
configured to forward incoming requests over the ssh connection to the local nginx server.

The proxy is configured with three environment variables:

Variable      | Description
------------- | -----------
ssh_host      |	hostname to use for the ssh connection
ssh_key       | base64 encoded contents of the private key to use
ssh_forward   | ssh -R argument: remote_port:local_host:local_port

See the Makefile for an example of how to configure these variables and pass them to docker-compose

## Remote nginx configuration
`/etc/nginx/sites-available/example-remote-proxied-server`
```
upstream remote_proxy {
  server 127.0.0.1:8000;
}

server {
...
  location / {
    proxy_pass                         http://remote_proxy;
    proxy_set_header Host              $http_host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
  }
...
}
```
