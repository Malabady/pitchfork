include ../../../mk/pitchfork.mk

# Local variables
_VER    = 0.13
_NAME   = pysam-$(_VER)
_WRKSRC = $(WORKDIR)/$(_NAME)

# Local works
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" \
        HTSLIB_MODE='external' \
        HTSLIB_INCLUDE_DIR="$(PREFIX)/src/htslib/include" \
        HTSLIB_LIBRARY_DIR="$(PREFIX)/src/htslib/lib" \
        $(PIP) install --root $(STAGING)/$(_NAME) --no-deps \
            "https://pypi.python.org/packages/31/17/31d317006a74941d2caddac97c5106601fe4da467653d0f061702e9ead95/$(_NAME).tar.gz#md5=a9b502dd1a7e6403e35e6972211688a2"
	rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	cd $(STAGING)/$(_NAME)$(PREFIX) && find * ! -type d|grep -v '^$$'|sort -r > $@
do-clean: do-flush
do-distclean: do-flush
do-flush:
	rm -rf $(STAGING)/$(_NAME)
