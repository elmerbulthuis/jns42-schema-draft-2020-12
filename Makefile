ifndef PACKAGE_NAME
override PACKAGE_NAME:=$(basename $(PWD))
endif

ifndef TAG
override TAG:=v0.0.0
endif

SHELL:=$(PREFIX)/bin/sh
PACKAGE_VERSION:=$(shell npx semver $(TAG))

rebuild: clean build

build: \
	out/static/version.txt \
	out/schema \

clean:
	rm -rf out

out/static/version.txt:
	@mkdir --parents $(@D)
	echo $(VERSION) > $@

out/%: src/%
	npx jns42-generator package file://${PWD}/$< \
		--package-directory $@ \
		--package-name $(PACKAGE_NAME) \
		--package-version $(PACKAGE_VERSION) \
		

	( cd $@ ; npm install --unsafe-perm )


.PHONY: \
	build \
	rebuild \
	clean \
