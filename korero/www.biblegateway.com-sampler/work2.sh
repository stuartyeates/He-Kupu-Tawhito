#!/bin/bash


cnt=1
while [ $cnt -ne ${FILECOUNT} ]
do
    files="$files Genesis+$cnt"
    cnt=$(( $cnt + 1 ))
done

echo filesnames
echo $files

# download and convert the files
for file in $files; 
do
#    for lang in MAORI KJV LYT DARBY VIET ALAB CUV CUVS;
    for lang in MAORI KJV;
     do
	if [ ! -e $file-$lang.orig.html ]
	then
	   wget "http://www.biblegateway.com/passage/?search="$file"&version="$lang --output-document=$file-$lang.orig.html
	   sleep 5
	fi
	make $file-$lang.words.xml
    done
done

#create the uber-file
cat import.xml.start > import.xml
for file in $files; 
do

cat >>import.xml <<END
  <div id="$file"> <xi:include href="$file-MAORI.words.xml"/> <xi:include href="$file-KJV.words.xml"/> </div>
END
done
cat import.xml.end >> import.xml
xmllint --xinclude import.xml |  xsltproc  ../../xsl/ensureXmlIds.xsl - > import.words.xml

