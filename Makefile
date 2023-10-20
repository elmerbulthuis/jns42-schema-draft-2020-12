SRC:=https://json-schema.org/draft/2020-12/schema

ifndef PACKAGE_NAME
override PACKAGE_NAME:=$(notdir $(basename $(PWD)))
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

out/%:
	npx jns42-generator package $(SRC) \
		--package-directory $@ \
		--package-name $(PACKAGE_NAME) \
		--package-version $(PACKAGE_VERSION) \
		

	( cd $@ ; npm install --unsafe-perm )


.PHONY: \
	build \
	rebuild \
	clean \
