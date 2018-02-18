COURSES = 202 211 212 220 221 231 233 240 245 
TEXS = $(foreach course, $(COURSES), $(course).tex)
PDFS = $(foreach course, $(COURSES), $(course).pdf)

.PHONY: all releaseall commit release clean 

all: $(TEXS) $(PDFS)

releaseall:
	for pdf in $(PDFS) ; do \
		make release pdf=$$pdf ; \
	done

commit:
	make $(course).pdf
	git add $(course).tex
	git commit
	git push origin master
	make release pdf="$(course).pdf"

release:
	github-release upload --security-token $(IC_SECOND_YEAR_NOTES_KEY) --user jordanspooner --repo ic-second-year-notes --tag current --name "$(pdf)" --replace --file $(pdf)

%.pdf: %.tex
	pdflatex $^

%.tex: %.lyx
	lyx -e latex $^
	sed -i '/^%%/ d' $@

clean:
	rm -f *.aux
	rm -f *.log
	rm -f *.out
