#
# makefile for multilingual bible from www.biblegateway.com
#

all:
	./work2.sh

%.fixedurls.xml: %.orig.xml
	cp $^ $@

%.orig.xml: %.orig.html
	tidy -utf8 -asxml -wrap 0 -n $^  |xsltproc --novalid ../../xsl/tidyBiblegateway.xsl -  |xmllint --format -  >  $@

%.words.xml: %.fixedurls.xml
	saxonb-xslt  $^  ../../xsl/tei2teiWords.xsl  > $@

clean:
	rm -rf  *.orig.xml *.fixedurls.xml *.words.xml import.xml

allclean: clean
	rm -rf *.html 

validate: 
	xmllint --noout *.xml


.PRECIOUS: %.orig.html 
