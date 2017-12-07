include ../../../mk/pitchfork.mk

# Local variables
_NAME            = nim-0.17.2
_URL             = http://nim-lang.org/download
_WRKSRC          = $(WORKDIR)/$(_NAME)
_FILE            = $(_NAME).tar.gz

# Local check
_tmpvar:=$(if $(shell which unzip),exists,$(error "unable to run unzip, consider doing yum install unzip"))

# Local works
do-fetch: $(_FILE)
$(_FILE):
	$(PFHOME)/bin/pitchfork fetch --url $(_URL)/$@
do-extract: $(_WRKSRC)
$(_WRKSRC): | do-fetch
	tar zxvf $(_FILE) -C $(WORKDIR)
do-build: $(_WRKSRC)/bin/nim
$(_WRKSRC)/bin/nim: | do-extract
	cd $(_WRKSRC) && sh build.sh
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	mkdir -p $(PREFIX)/share/doc
	cd $(_WRKSRC) && sh install.sh $(STAGING)/$(_NAME)
	cp -a $(STAGING)/$(_NAME)/nim/bin/nim  $(PREFIX)/bin/
	cp -a $(STAGING)/$(_NAME)/nim/lib      $(PREFIX)/lib/nim
	cp -a $(STAGING)/$(_NAME)/nim/doc      $(PREFIX)/share/doc/nim
	cp -a $(STAGING)/$(_NAME)/nim/config/* $(PREFIX)/etc/
	echo bin/nim >  $@
	echo lib/nim >> $@
	echo share/doc/nim >> $@
	find $(STAGING)/$(_NAME)/nim/config ! -type d | awk -F '$(STAGING)/$(_NAME)/nim/config/' '{print "etc/"$$2}' >> $@
do-clean: do-flush
do-distclean: do-flush
do-flush:
	rm -rf $(_WRKSRC)
	rm -f build.log install.log
