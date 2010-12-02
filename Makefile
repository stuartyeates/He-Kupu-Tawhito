EXIST_HOME=$(PWD)/eXist-install
JAVA_OPTS=-Xmx1000m -Dfile.encoding=UTF-8
JAVA_OPTIONS="-Xmx1000m -Dfile.encoding=UTF-8"
CLIENT_JAVA_OPTIONS="-Xmx1000m -Dfile.encoding=UTF-8"

all: $(EXIST_HOME) start-exist auto-exist 

docs:
	@$(MAKE) --keep-going --directory=korero/www.nzetc.org 
	@$(MAKE) --keep-going --directory=korero/www.biblegateway.com
	@$(MAKE) --keep-going --directory=korero/www.mixandmash.org.nz

$(EXIST_HOME): exist/eXist-setup-1.4.0-rev10440.jar
	java -jar exist/eXist-setup-1.4.0-rev10440.jar -p  $(EXIST_HOME)
	cat $(EXIST_HOME)/bin/functions.d/eXist-settings.sh | sed 's/-Xmx512m/-Xmx1500m/' > tmp.settings
	mv tmp.settings $(EXIST_HOME)/bin/functions.d/eXist-settings.sh
	cat $(EXIST_HOME)/tools/jetty/etc/jetty.xml | sed 's/8080/8081/' > tmp.settings
	mv tmp.settings $(EXIST_HOME)/tools/jetty/etc/jetty.xml
	cat $(EXIST_HOME)/client.properties  | sed 's/8080/8081/' > tmp.settings
	mv tmp.settings $(EXIST_HOME)/client.properties
	mkdir -p $(EXIST_HOME)/webapp/he_kupu_tawhito/
	cp teitext2teientries.xql $(EXIST_HOME)/webapp/he_kupu_tawhito/kupu.xql
	cp teiresults2htmlresults.xsl $(EXIST_HOME)/webapp/he_kupu_tawhito/

all-clean: stop-exist
	rm -rf $(EXIST_HOME) ./exist.log

start-exist:
	( JAVA_OPTIONS=$(JAVA_OPTIONS) $(EXIST_HOME)/bin/startup.sh >> ./exist.log)&
	sleep 5
#	sleep 15
#	firefox http://localhost:8080/exist/ &
#	sleep 5
#	firefox http://localhost:8080/exist/admin/admin.xql &

auto-exist:
#	$(EXIST_HOME)/bin/client.sh -m /db/kupu/korero
#	$(EXIST_HOME)/bin/client.sh -m /db/kupu/korero -p korero/www.nzetc.org/*.words.xml
	$(EXIST_HOME)/bin/client.sh uri=xmldb:exist://localhost:8081/exist/xmlrpc -m /db/kupu/korero -p korero/www.biblegateway.com/import.words.xml
	firefox http://localhost:8081/exist/he_kupu_tawhito/kupu.xql &

query-exist: $(EXIST_HOME)
	time --verbose $(EXIST_HOME)/bin/client.sh  -F teitext2teientries.xq --output teitext2teientries.out.xml

stop-exist:
	 $(EXIST_HOME)/bin/shutdown.sh
