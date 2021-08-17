PREFIX    ?= /usr/local
BINDIR    ?= $(PREFIX)/bin

install:
	mkdir -p $(BINDIR)
	install aws-env.sh secrets/* config/* $(BINDIR)/

uninstall:
	rm -f $(BINDIR)/aws-env
