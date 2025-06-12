NS = 0000matteo0000
REPO = latex
IMAGE = $(NS)/$(REPO)

.PHONY: build build_ubuntu build_basic build_full

build: build_ubuntu build_basic  # build_full

publish: publish_ubuntu publish_latest publish_basic  # publish_full

build_ubuntu: Dockerfile.ubuntu
	docker build -f Dockerfile.ubuntu --progress=plain -t $(IMAGE):ubuntu .

publish_ubuntu: build_ubuntu
	docker tag $(IMAGE):ubuntu $(NS)/$(REPO):ubuntu
	docker push $(NS)/$(REPO):ubuntu

build_basic: Dockerfile.basic
	docker build -f Dockerfile.basic --progress=plain -t $(IMAGE):ctanbasic .

publish_basic: build_basic
	docker tag $(IMAGE):ctanbasic $(NS)/$(REPO):ctanbasic
	docker push $(NS)/$(REPO):ctanbasic

build_full: build_basic Dockerfile.full
	docker build -f Dockerfile.full --progress=plain -t $(IMAGE):ctanfull .

publish_full: build_full
	docker tag $(IMAGE):ctanfull $(NS)/$(REPO):ctanfull
	docker push $(NS)/$(REPO):ctanfull

publish_latest: build_ubuntu
	docker tag $(IMAGE):ubuntu $(NS)/$(REPO):latest
	docker push $(NS)/$(REPO):latest

default: build
