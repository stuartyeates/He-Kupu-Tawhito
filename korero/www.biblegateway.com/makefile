#
# makefile for multilingual bible from www.biblegateway.com
#

all:
	./work.sh

%.fixedurls.xml: %.orig.xml
	cp $^ $@

%.orig.xml: %.orig.html
	tidy -asxml -wrap 0 -n $^  |xsltproc --novalid ../../xsl/tidyBiblegateway.xsl -  |xmllint --format -  >  $@

%.words.xml: %.fixedurls.xml
	saxonb-xslt  $^  ../../xsl/tei2teiWords.xsl  > $@

clean:
	rm -rf  *.orig.xml *.fixedurls.xml *.words.xml

allclean: clean
	rm -rf *.html


.PRECIOUS: %.orig.html %.words.xml
