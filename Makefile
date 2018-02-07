DOCKER=docker
DOCKER_IMAGE=cbsan/sybase:16-server

build :
	$(DOCKER) build -t $(DOCKER_IMAGE) .

run :
	$(DOCKER) run --rm $(DOCKER_IMAGE)

all : build
