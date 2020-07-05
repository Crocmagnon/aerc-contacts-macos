prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib

build:
	swift build -c release --disable-sandbox

install: build
	install ".build/release/aerc-contacts-cli" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/aerc-contacts-cli"

clean:
	rm -rf .build

.PHONY: build install uninstall clean
