MANPAGES    = $(PROGS-yes:%=doc/%.1)
PODPAGES    = $(PROGS-yes:%=doc/%.pod)
HTMLPAGES   = $(PROGS-yes:%=doc/%.html)                                 \
              doc/developer.html                                        \
              doc/faq.html                                              \
              doc/fate.html                                             \
              doc/general.html                                          \
              doc/git-howto.html                                        \
              doc/libavfilter.html                                      \
              doc/nut.html                                              \
              doc/platform.html                                         \

DOCS = $(HTMLPAGES) $(MANPAGES) $(PODPAGES)

all-$(CONFIG_DOC): documentation

apidoc: doc/doxy/html
documentation: $(DOCS)

TEXIDEP = awk '/^@include/ { printf "$@: $(@D)/%s\n", $$2 }' <$< >$(@:%=%.d)

GENTEXI  = format codec
GENTEXI := $(GENTEXI:%=doc/avoptions_%.texi)

$(GENTEXI): TAG = GENTEXI
$(GENTEXI): doc/avoptions_%.texi: doc/print_options
	$(M)doc/print_options $* > $@

doc/%.html: TAG = HTML
doc/%.html: doc/%.texi $(SRC_PATH)/doc/t2h.init $(GENTEXI)
	$(Q)$(TEXIDEP)
	$(M)texi2html -I doc -monolithic --init-file $(SRC_PATH)/doc/t2h.init --output $@ $<

doc/%.pod: TAG = POD
doc/%.pod: doc/%.texi $(SRC_PATH)/doc/texi2pod.pl $(GENTEXI)
	$(Q)$(TEXIDEP)
	$(M)$(SRC_PATH)/doc/texi2pod.pl -Idoc $< $@

doc/%.1: TAG = MAN
doc/%.1: doc/%.pod $(GENTEXI)
	$(M)pod2man --section=1 --center=" " --release=" " $< > $@

$(DOCS) doc/doxy/html: | doc/

doc/doxy/html: $(SRC_PATH)/doc/Doxyfile $(INSTHEADERS)
	$(M)$(SRC_PATH)/doc/doxy-wrapper.sh $(SRC_PATH) $^

install-progs-$(CONFIG_DOC): install-man

install-man: $(MANPAGES)
	$(Q)mkdir -p "$(MANDIR)/man1"
	$(INSTALL) -m 644 $(MANPAGES) "$(MANDIR)/man1"

uninstall: uninstall-man

uninstall-man:
	$(RM) $(addprefix "$(MANDIR)/man1/",$(ALLMANPAGES))

clean::
	$(RM) doc/*.html doc/*.pod doc/*.1 $(CLEANSUFFIXES:%=doc/%) doc/avoptions_*.texi
	$(RM) -r doc/doxy/html

-include $(wildcard $(DOCS:%=%.d))

.PHONY: apidoc documentation
