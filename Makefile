MDDOCS = $(shell find . -type f -name '*.md')
HTMLDOCS = $(MDDOCS:.md=.html)

PANDOC = pandoc

%.html: %.md
	sed 's/__/\&nbsp;/g' $< | $(PANDOC) $(PANDOC_ARGS) \
		--standalone --strip-comments --from=gfm \
		--lua-filter=filters/title-from-h1.lua \
		--css /style.css -o $@

all: $(HTMLDOCS)

docs/baystate-marathon/baystate-marathon-volunteer-faq.html: PANDOC_ARGS+=--toc
docs/baystate-marathon/baystate-marathon-volunteer-faq.html: PANDOC_ARGS+=--lua-filter=filters/link-to-toc.lua

clean:
	rm -f $(HTMLDOCS)
