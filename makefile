# this is where we're going to install exist
EXIST_HOME=$(PWD)/eXist-install
# this is where we've already downloaded the latest eXist-db installer to
EXIST_ZIP=$(PWD)/../eXist-setup-1.4.0-rev10440.jar
JAVA_OPTS=-"Xmx6000m -Dfile.encoding=UTF-8"
JAVA_OPTIONS="-Xmx6000m -Dfile.encoding=UTF-8"
CLIENT_JAVA_OPTIONS="-Xmx6000m -Dfile.encoding=UTF-8"

all: $(EXIST_HOME) start-exist auto-exist 

docs:
#	@$(MAKE) --keep-going --directory=korero/www.nzetc.org 
#	@$(MAKE) --keep-going --directory=korero/www.biblegateway.com
#	@$(MAKE) --keep-going --directory=korero/www.biblegateway.com-sampler

# unpack exist and modify the default settings. The java memory 
# settings are heavily dependent on whether this machine is a 32 
# or 64 bit machine and how much memory is available 
$(EXIST_HOME): $(EXIST_ZIP)
	java -jar $(EXIST_ZIP) -p  $(EXIST_HOME)
	cat $(EXIST_HOME)/bin/functions.d/eXist-settings.sh | sed 's/-Xmx512m/-Xmx6000m/' > tmp.settings
	mv tmp.settings $(EXIST_HOME)/bin/functions.d/eXist-settings.sh
	cat $(EXIST_HOME)/tools/jetty/etc/jetty.xml | sed 's/8080/8081/' > tmp.settings
	mv tmp.settings $(EXIST_HOME)/tools/jetty/etc/jetty.xml
	cat $(EXIST_HOME)/client.properties  | sed 's/8080/8081/' > tmp.settings
	mv tmp.settings $(EXIST_HOME)/client.properties
	mkdir -p $(EXIST_HOME)/webapp/he_kupu_tawhito/
	cp teitext2teientries.xql $(EXIST_HOME)/webapp/he_kupu_tawhito/kupu.xql
	cp teiresults2htmlresults.xsl $(EXIST_HOME)/webapp/he_kupu_tawhito/
	xsltproc xsl/updateExistOptions.xsl $(EXIST_HOME)/conf.xml > tmp.settings
	mv tmp.settings $(EXIST_HOME)/conf.xml
	xsltproc xsl/updateExistOptions.xsl $(EXIST_HOME)/conf.xml > tmp.settings
	mv tmp.settings $(EXIST_HOME)/conf.xml
	xsltproc xsl/updatelog4j.xsl $(EXIST_HOME)/log4j.xml > tmp.settings
	mv tmp.settings $(EXIST_HOME)/log4j.xml

allclean: stop-exist
	rm -rf $(EXIST_HOME) ./exist.log

# the sleep is needed here because it gives exist (which is runnng the background) time to start and initialise
start-exist:
	( JAVA_OPTIONS=$(JAVA_OPTIONS) $(EXIST_HOME)/bin/startup.sh >> $(EXIST_HOME)/eXist.log)&
	sleep 5

# the first data file we load is a metadata file describing the
# indexes we want to build as the other files are loaded. See
#  http://exist.sourceforge.net/tuning.html
auto-exist:
	$(EXIST_HOME)/bin/client.sh uri=xmldb:exist://localhost:8081/exist/xmlrpc -m /db/system/config/db/he_kupu_tawhito/ -p collection.xconf --no-gui
#	$(EXIST_HOME)/bin/client.sh uri=xmldb:exist://localhost:8081/exist/xmlrpc -m /db/he_kupu_tawhito/ -p korero/www.biblegateway.com/import.words.xml --no-gui
	$(EXIST_HOME)/bin/client.sh uri=xmldb:exist://localhost:8081/exist/xmlrpc -m /db/he_kupu_tawhito/ -p korero/www.nzetc.org/A*.words.xml
	firefox http://localhost:8081/exist/he_kupu_tawhito/kupu.xql &

query-exist: $(EXIST_HOME)
	time --verbose $(EXIST_HOME)/bin/client.sh  -F teitext2teientries.xq --output teitext2teientries.out.xml

stop-exist:
	 $(EXIST_HOME)/bin/shutdown.sh
