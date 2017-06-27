override SELF_DIR:=$(dir $(lastword $(MAKEFILE_LIST)))
override PFHOME:=$(realpath $(SELF_DIR)/..)

include $(SELF_DIR)/config.mk

default:
	@echo "[INFO] nothing is done."

do-uninstall:
	@PREFIX=$(PREFIX) $(PFHOME)/bin/uninstall $(_NAME)
#do-distclean: do-clean
provided:
