BIN = ./node_modules/.bin/
SRC = $(shell find lib -name "*.js")
BUILD = $(subst lib,build,$(SRC))
NODE ?= node

build:
	@mkdir -p build/remotes
	@$(MAKE) $(BUILD)

build/%.js: lib/%.js
	@$(BIN)regenerator $< > $@

clean:
	@rm -rf build

test tests:
	@$(NODE) $(BIN)mocha \
		--timeout 4000 \
		--require should \
		--reporter spec \
		--harmony-generators \
		--bail

.PHONY: test tests build clean
