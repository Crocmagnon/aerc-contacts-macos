prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib

build:
	swift build -c release --disable-sandbox

install: build
	install ".build/release/aerc-contacts" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/aerc-contacts"

clean:
	rm -rf .build

bottle:
	echo "This hasn't yet been tested."
	mkdir -p .build/bottles
	cd .build/bottles
	brew test-bot --skip-setup --root-url https://dl.bintray.com/crocmagnon/bottles-formulae --bintray-org=crocmagnon --tap=crocmagnon/homebrew-formulae aerc-contacts

publish: bottle
	echo "This hasn't yet been tested."
	brew pr-upload --bintray-org=crocmagnon --root-url=https://dl.bintray.com/crocmagnon/bottles-formulae
	git -C /usr/local/Homebrew/Library/Taps/crocmagnon/homebrew-formulae/ format-patch -1 HEAD -o $(PWD)
	echo "Don't forget to apply the patch to your homebrew repo and push ;)"


.PHONY: build install uninstall clean
