#!/bin/bash

files="Genesis+1 Genesis+2 Genesis+3 Genesis+4 Genesis+5 Genesis+6 Genesis+7 Genesis+8 Genesis+9 Genesis+10 Genesis+11 Genesis+12 Genesis+13 Genesis+14 Genesis+15 Genesis+16 Genesis+17 Genesis+18 Genesis+19 Genesis+20 Genesis+21 Genesis+22 Genesis+23 Genesis+24 Genesis+25 Genesis+26 Genesis+27 Genesis+28 Genesis+29 Genesis+30 Genesis+31 Genesis+32 Genesis+33 Genesis+34 Genesis+35 Genesis+36 Genesis+37 Genesis+38 Genesis+39 Genesis+40 Genesis+41 Genesis+42 Genesis+43 Genesis+44 Genesis+45 Genesis+46 Genesis+47 Genesis+48 Genesis+49 Genesis+50"



for file in $files; 
do
	if [ ! -e $file-MAORI.orig.html ]
	then
	    wget "http://www.biblegateway.com/passage/?search="$file"&version=MAORI" --output-document=$file-MAORI.orig.html&
	fi
	tidy -asxml -wrap 0 -n $file-MAORI.orig.html  | xsltproc --novalid clean.xsl -  | xmllint --format -  > $file-MAORI.orig.xml
	make $file-MAORI.words.xml

	if [ ! -e $file-KJV.orig.html ]
	then
	    wget "http://www.biblegateway.com/passage/?search="$file"&version=KJV" --output-document=$file-KJV.orig.html&
	fi
	tidy -asxml -wrap 0 -n $file-KJV.orig.html  |xsltproc --novalid clean.xsl -  |xmllint --format -  > $file-KJV.orig.xml
	make $file-KJV.words.xml


done