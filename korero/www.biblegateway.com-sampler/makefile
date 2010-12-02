#files=GorLaws.orig.xml GovActs.orig.xml GovActs.orig.html
#HTMLXSLT=~/tei-svn/Stylesheets/html/tei.xsl
#
#%.orig.xml:
#	wget http://www.nzetc.org/tei-source/$*.xml --output-document=$@
#
#%.html: %.xml
#	xsltproc $(HTMLXSLT) $^ > $@
#
#all: $(files)
#
#

files="Genesis+1 Genesis+2 Genesis+3 Genesis+4 Genesis+5 Genesis+6 Genesis+7"

all:
	./work2.sh

%.fixedurls.xml: %.orig.xml
#	xsltproc  teinormalise.xsl $^  > $@
	cp $^ $@

%.orig.xml: %.orig.html
	tidy -utf8 -asxml -wrap 0 -n $^  |xsltproc --novalid clean.xsl -  |xmllint --format -  >  $@

%.words.xml: %.fixedurls.xml
	saxonb-xslt  $^ ../www.nzetc.org/tei2teiWords.xsl  > $@

clean:
	rm -rf  *.orig.xml *.fixedurls.xml *.words.xml

allclean: clean
	rm -rf *.html

validate: 
	xmllint --noout Random\ Words.xml


.PRECIOUS: %.orig.html %.xml %.fixedurls.xml %.orig.xml %.words.xml
