include ../../../mk/pitchfork.mk

# Local variables
_VER    = 0.4
_NAME   = rdfextras-$(_VER)
_WRKSRC = $(WORKDIR)/$(_NAME)

# Local works
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	$(PIP) install --root $(STAGING)/$(_NAME) --no-deps rdfextras==$(_VER)
	rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	cd $(STAGING)/$(_NAME)$(PREFIX) && find * ! -type d|grep -v '^$$'|sort -r > $@
do-clean: do-flush
do-distclean: do-flush
do-flush:
	rm -rf $(STAGING)/$(_NAME)
