info ::
	@echo "make pdf, make bundle"
pdf :
	pdflatex TeXbyTopic
	bibtex TeXbyTopic
	makeindex TeXbyTopic
	pdflatex TeXbyTopic
	pdflatex TeXbyTopic
	if [ "`whoami`" = "eijkhout" ] ; then \
	  cp TeXbyTopic.pdf ${HOME}/DropBox/SciComp ; \
	fi
bundle :
	tar --gzip -f texbytopic.tgz -c \
	    README TeXbyTopic.pdf \
	    TeXbyTopic.tex figflow.tex glossary.tex  tables.tex tex.bib
clean :
	rm -f *.{aux,blg,brf,log,out,ilg,toc} *~
