
run: build
	docker-compose up

build:
	@env \
        ssh_key=$(shell cat ~/.ssh/id_rsa | base64 -w0) \
        ssh_host=awx.rstms.net \
        ssh_forward=8000:nginx:80 \
        docker-compose build
