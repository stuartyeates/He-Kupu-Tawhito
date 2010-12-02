#!/bin/bash


cnt=1
while [ $cnt -ne 10 ]
do
    files="$files Genesis+$cnt"
    cnt=$(( $cnt + 1 ))
done

echo filesnames
echo $files

# download and convert the files
for file in $files; 
do
    for lang in MAORI KJV LYT DARBY VIET ALAB CUV CUVS;
    do
	if [ ! -e $file-$lang.orig.html ]
	then
	   wget "http://www.biblegateway.com/passage/?search="$file"&version="$lang --output-document=$file-$lang.orig.html
	fi
	make $file-$lang.words.xml
    done
done

#create the uber-file
xmllint --xinclude import.xml |  xsltproc  teinormalise.xsl - > import.words.xml

