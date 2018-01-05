include ../../../mk/pitchfork.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME             = minorseq
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/$(_NAME)
_WRKSRC           = $(WORKDIR)/$(_NAME)
$(_NAME)_VERSION ?= HEAD
_REVISION         = $(shell cd $(_WRKSRC) && $(GIT) rev-parse --short $($(_NAME)_VERSION) || true)

# Local works
do-fetch: $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
else
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
endif
ifneq ($(wildcard $(PREFIX)/lib/libpbbam.$(DYLIB)),)
PacBioBAM_LIBRARIES = $(PREFIX)/lib/libpbbam.$(DYLIB)
else
PacBioBAM_LIBRARIES = $(PREFIX)/lib/libpbbam.a
endif
do-config: $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile: | do-fetch
	mkdir -p $(_WRKSRC)/_build
	cd $(_WRKSRC)/_build \
     && $(CMAKE) \
          -DMS_build_tests=OFF \
          -DZLIB_INCLUDE_DIRS=$(PREFIX)/include \
          -DZLIB_LIBRARIES=$(PREFIX)/lib/libz.${DYLIB} \
          -DBoost_INCLUDE_DIRS=$(BOOST_ROOT)/include \
          -DPacBioBAM_INCLUDE_DIRS=$(PREFIX)/include \
          -DPacBioBAM_LIBRARIES=$(PacBioBAM_LIBRARIES) \
          -Dpbcopper_INCLUDE_DIRS=$(PREFIX)/include \
          -Dpbcopper_LIBRARIES=$(PREFIX)/lib/libpbcopper.a \
          -DHTSLIB_INCLUDE_DIRS=$(PREFIX)/src/htslib/include \
          -DHTSLIB_LIBRARIES=$(PREFIX)/src/htslib/lib/libhts.a \
        ..
do-build: $(_WRKSRC)/_build/cleric
$(_WRKSRC)/_build/cleric: | do-config
	cd $(_WRKSRC)/_build && $(MAKE)
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	rsync -ax $(_WRKSRC)/_build/cleric $(PREFIX)/bin/
	@cd $(PREFIX) && find bin/cleric -type f > $@
	@echo "# $(_REVISION)" >> $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/_build clean || rm -rf $(_WRKSRC)/_build
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
