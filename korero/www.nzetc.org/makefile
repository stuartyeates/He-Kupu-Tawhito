files=GorLaws.words.xml GovActs.words.xml 
HTMLXSLT=~/tei-svn/Stylesheets/html/tei.xsl

%.orig.xml:
	wget http://www.nzetc.org/tei-source/$*.xml --output-document=$@

%.fixedurls.xml: %.orig.xml
	xsltproc  tei2NZETCURLs.xsl $^  | xsltproc fix-structure.xsl  - > $@

%.words.xml: %.fixedurls.xml
	saxonb-xslt  $^ tei2teiWords.xsl  > $@

%.html: %.xml
	xsltproc $(HTMLXSLT) $^ > $@

all: $(files)


clean:
	rm -rf *.html *.fixedurls.xml *.words.xml

allclean: clean
	rm -rf *.xml

validate: 
	xmllint --noout Random\ Words.xml

.PRECIOUS: %.orig.xml
