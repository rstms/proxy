FROM alpine

RUN apk --no-cache add openssh-client

ARG ssh_key
ARG ssh_host
ARG ssh_forward

RUN  mkdir -m 0700 ~/.ssh
RUN  echo $ssh_key | base64 -d >~/.ssh/id_rsa 
RUN chmod 0400 ~/.ssh/id_rsa
RUN ssh-keyscan $ssh_host >> ~/.ssh/known_hosts
RUN echo "exec ssh -Nvg -R $ssh_forward $ssh_host" > /usr/local/bin/run-proxy
RUN chmod 0755 /usr/local/bin/run-proxy

CMD run-proxy
