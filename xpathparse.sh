#! /bin/bash
#Requires the perl xpath utility

#Make sure none of our entries start off as null
count=1
max=`xpath xkcdXMLarchive.xml /comicRoot/entry[last\(\)]/number 2>/dev/null | sed -e 's/<[^>]*>//g'`

function tsearch {

while [ $count -le $max ]
do
    echo "Parsing the title of comic $count..."
    TITLE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/title 2>/dev/null | sed -e 's/<[^>]*>//g'`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$TITLE" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done

}

function nsearch {

while [ $count -le $max ]
do
    echo "Parsing the number of comic $count..."
    NUMBER=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/number 2>/dev/null | sed -e 's/<[^>]*>//g'`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$NUMBER" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done


}

function lsearch {

while [ $count -le $max ]
do
    echo "Parsing the link of comic $count..."
    IMAGELINK=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/imageLink 2>/dev/null | sed -e 's/<[^>]*>//g'`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$IMAGELINK" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done


}

function ssearch {

while [ $count -le $max ]
do
    echo "Parsing the transcript of comic $count..."
    TRANSCRIPT=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/transcript 2>/dev/null | sed -e 's/<[^>]*>//g'`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$TRANSCRIPT" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done


}

function asearch {

while [ $count -le $max ]
do
    echo "Parsing the alt text of comic $count..."
    ALTTEXT=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/alttext 2>/dev/null | sed -e 's/<[^>]*>//g'`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$ALTTEXT" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done


}

function dsearch {

while [ $count -le $max ]
do
    echo "Parsing the date of comic $count..."
    DATE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/date 2>/dev/null | sed -e 's/<[^>]*>//g'`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$DATE" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done


}

function grabvalues {
    echo "Grabbing values..."
    ENTRY=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count] 2>/dev/null`
    TITLE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/title 2>/dev/null | sed -e 's/<[^>]*>//g'`
    NUMBER=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/number 2>/dev/null | sed -e 's/<[^>]*>//g'`
    IMAGELINK=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/imageLink 2>/dev/null | sed -e 's/<[^>]*>//g'`
    TRANSCRIPT=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/transcript 2>/dev/null | sed -e 's/<[^>]*>//g'`
    ALTTEXT=`xpath xkcdXMLarchive /comicRoot/entry[$count]/alttext 2>/dev/null | sed -e 's/<[^>]*>//g'`
    DATE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/date 2>/dev/null | sed -e 's/<[^>]*>//g'`
}

function printvalues {
        echo ""
        echo "Title: $TITLE"
        echo "Number: $NUMBER"
        echo "Image Link: $IMAGELINK"
        echo "Transcript: $TRANSCRIPT"
        echo "Alt Text: $ALTTEXT"
        echo "Date: $DATE"
        echo ""

}

while getopts ":t:n:l:s:a:d:" opt; do
    case $opt in
      t)
          query=$OPTARG && tsearch
          exit 0
      ;;
      n)
          query=$OPTARG && nsearch
          exit 0
      ;;
      l)
          query=$OPTARG && lsearch
          exit 0
      ;;
      s)
          query=$OPTARG && ssearch
          exit 0
      ;;
      a)
          query=$OPTARG && asearch
          exit 0
      ;;
      d)
          query=$OPTARG && dsearch
          exit 0
      ;;
      \?)
          echo "Invalid option: -$OPTARG" >&2
          exit 1
      ;;
      :)
          echo "Option -$OPTARG requires an argument." >&2
          exit 1
      ;;
    esac
done
