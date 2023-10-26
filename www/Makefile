include ../common/base.mk
include ../common/docker.mk

ifndef DOCKERENV
ifeq (,$(shell command -v node))
  $(error "node is not available please install node")
endif
ifeq (,$(shell command -v yarn))
  $(error "yarn is not available please install yarn")
endif
endif

build:: node_modules
ifdef DOCKERENV
	source ~/.bashrc && yarn build
else
	yarn build
endif

serve:: build
	yarn dev

site:: build gh-pages
	rm -fr gh-pages/*
	cp -r build/* gh-pages/

publish:: site
	git -C gh-pages add -A
	git -C gh-pages commit -m "$$(date)"
	git -C gh-pages push origin gh-pages

test::

clean::
	[[ -h node_modules ]] && $(RM) node_modules || true
	$(RM) -r build/ gh-pages/

distclean::
	$(RM) -r node_modules/

node_modules: package.json
ifdef DOCKERENV
	ln -s /$@ $@
else
	yarn install
endif

gh-pages:
	git worktree prune
	git worktree add $@

docker-site:: docker-build gh-pages
	rm -fr node_modules
	docker run --rm -it \
	    --volume $(ROOT):/host \
	    --workdir /host/$(SUBDIR) \
	    -u $$DOCKER_UID:$$DOCKER_GID \
	    $(DOCKER_IMAGE) \
	    make site
	unlink node_modules

Dockerfile:: $(COMMON) Makefile
	cat \
	  $</docker-from-ubuntu.dockerfile \
	  $</docker-apt-base.dockerfile \
	  $</docker-useradd.dockerfile \
	  $</docker-apt-node.dockerfile \
	  $</docker-deps-node.dockerfile \
	  $</docker-apt-dev.dockerfile \
		> $@
