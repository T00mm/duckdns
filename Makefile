DESTDIR = ''
PREFIX = '/usr'
EXECUTABLE_NAME = duckdns
VERSION = 1.1
ARCHPKG = $(EXECUTABLE_NAME)-$(VERSION)-1-any.pkg.tar.xz

man: $(EXECUTABLE_NAME).1.gz

$(EXECUTABLE_NAME).1.gz: README.rst
	rst2man $^ | gzip -c > $@

install:
	install -m 755 -D $(EXECUTABLE_NAME).sh $(DESTDIR)$(PREFIX)/bin/$(EXECUTABLE_NAME)
	install -m 755 -d $(DESTDIR)/etc/$(EXECUTABLE_NAME).d
	install -m 644 -D default.cfg $(DESTDIR)/etc/$(EXECUTABLE_NAME).d/default.cfg
	install -m 644 -D $(EXECUTABLE_NAME).1.gz $(DESTDIR)$(PREFIX)/share/man/man1/$(EXECUTABLE_NAME).1.gz



install_services:
	install -m 644 -D $(EXECUTABLE_NAME).service $(DESTDIR)/lib/systemd/system/$(EXECUTABLE_NAME).service
	install -m 644 -D $(EXECUTABLE_NAME).timer $(DESTDIR)/lib/systemd/system/$(EXECUTABLE_NAME).timer

arch_install_services:
	install -m 644 -D $(EXECUTABLE_NAME).service $(DESTDIR)$(PREFIX)/lib/systemd/system/$(EXECUTABLE_NAME).service
	install -m 644 -D $(EXECUTABLE_NAME).timer $(DESTDIR)$(PREFIX)/lib/systemd/system/$(EXECUTABLE_NAME).timer

uninstall:
	rm -f $(PREFIX)/bin/$(EXECUTABLE_NAME)
	rm -f /etc/$(EXECUTABLE_NAME).d/default.cfg
	rm -f /lib/systemd/system/$(EXECUTABLE_NAME).service
	rm -f /lib/systemd/system/$(EXECUTABLE_NAME).timer

full_uninstall: uninstall
	rm -rf /etc/$(EXECUTABLE_NAME).d/

arch_pkg: $(ARCHPKG)

PKGBUILD: pkgbuild.in
	cat pkgbuild.in > PKGBUILD
	sed -i "s|pkgname=|pkgname=$(EXECUTABLE_NAME)|" PKGBUILD
	sed -i "s|pkgver=|pkgver=$(VERSION)|" PKGBUILD
	makepkg -g >> PKGBUILD

$(ARCHPKG): PKGBUILD
	makepkg -d
	@echo
	@echo Package done!
	@echo You can install it as root with:
	@echo pacman -U $@

clean:
	rm -f PKGBUILD $(ARCHPKG) $(EXECUTABLE_NAME).1.gz

.PHONY: clean man install install_services arch_install_services uninstall full_uninstall arch_pkg
