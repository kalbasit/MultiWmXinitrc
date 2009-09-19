VERSION=1.0

prefix=/usr/local
bindir=$(prefix)/bin
libdir=$(prefix)/lib
sharedir=$(prefix)/share
bashlibdir=$(libdir)/bash
INSTALL=install
MAKE=make

all: targets;

targets: make-bin-targets make-lib-targets
	sed -e "s:@VERSION@:$(VERSION):g" \
		-e "s:@BASHLIBDIR@:$(bashlibdir):g" \
		Xinitrc.in > Xinitrc

make-bin-targets:
	sed -e "s:\(VERSION=\).*:\1$(VERSION):g" bin/Makefile.in > bin/Makefile
	$(MAKE) -C bin targets

make-lib-targets:
	$(MAKE) -C lib targets

install:
	$(INSTALL) -d -m 755 $(DESTDIR)$(bindir)
	$(INSTALL) -d -m 755 $(DESTDIR)$(sharedir)
	$(INSTALL) -d -m 755 $(DESTDIR)$(bashlibdir)
	$(INSTALL) -m 644 Xinitrc $(DESTDIR)$(sharedir)/Xinitrc
	$(MAKE) -C bin install
	$(MAKE) -C lib install

clean:
	sed -e "s:\(VERSION=\).*:\1$(VERSION):g" bin/Makefile.in > bin/Makefile
	$(MAKE) -C bin clean
	$(MAKE) -C lib clean
	rm -f Xinitrc
	rm -f bin/Makefile
