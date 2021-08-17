PREFIX    ?= /usr/local
BINDIR    ?= $(PREFIX)/bin

install:
	mkdir -p $(BINDIR)
	mkdir -p $(BINDIR)/aws-env-secrets
	mkdir -p $(BINDIR)/aws-env-config
	install aws-env.sh $(BINDIR)/aws-env
	install aws-env-secrets/* $(BINDIR)/aws-env-secrets
	install aws-env-config/* $(BINDIR)/aws-env-config

uninstall:
	rm -f $(BINDIR)/aws-env
	rm -rf $(BINDIR)/aws-env-secrets
	rm -rf $(BINDIR)/aws-env-config
