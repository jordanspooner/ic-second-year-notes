TARGETS = 202.tex 211.tex 212.tex 220.tex 221.tex 231.tex 233.tex 240.tex 245.tex 202.pdf 211.pdf 212.pdf 220.pdf 221.pdf 231.pdf 233.pdf 240.pdf 245.pdf

.PHONY: all clean commit

all: $(TARGETS)

commit:
	make $(course).pdf
	git add $(course).tex
	git commit
	git push origin master
	github-release upload --security-token $(IC_SECOND_YEAR_NOTES_KEY) --user jordanspooner --repo ic-second-year-notes --tag current --name "$(course).pdf" --replace --file $(course).pdf

%.pdf: %.tex
	pdflatex $^

%.tex: %.lyx
	lyx -e latex $^
	sed -i '/^%%/ d' $@

clean:
	rm -f *.aux
	rm -f *.log
	rm -f *.out
