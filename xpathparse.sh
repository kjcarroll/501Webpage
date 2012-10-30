#! /bin/bash
#Requires the perl xpath utility

#Make sure none of our entries start off as null
ENTRY=INITIALIZED
TITLE=INITIALIED
NUMBER=INITIALIZED
IMAGELINK=INITIALIZED
TRANSCRIPT=INITIALIZED
ALTTEXT=INITIALIZED
DATE=INITIALIZED
count=1
function tsearch {

while [ -n "$ENTRY" ]
do
    echo "Parsing the title of comic $count..."
    TITLE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/title 2>/dev/null | sed -e 's/<[^>]*>//g'`
    ENTRY=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count] 2>/dev/null`
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

while [ -n "$ENTRY" ]
do
    echo "Parsing the title of comic $count..."
    TITLE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/title 2>/dev/null | sed -e 's/<[^>]*>//g'`
    ENTRY=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count] 2>/dev/null`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$TITLE" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done


}

function lsearch {

while [ -n "$ENTRY" ]
do
    echo "Parsing the title of comic $count..."
    TITLE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/title 2>/dev/null | sed -e 's/<[^>]*>//g'`
    ENTRY=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count] 2>/dev/null`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$TITLE" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done


}

function ssearch {

while [ -n "$ENTRY" ]
do
    echo "Parsing the title of comic $count..."
    TITLE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/title 2>/dev/null | sed -e 's/<[^>]*>//g'`
    ENTRY=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count] 2>/dev/null`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$TITLE" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done


}

function asearch {

while [ -n "$ENTRY" ]
do
    echo "Parsing the title of comic $count..."
    TITLE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/title 2>/dev/null | sed -e 's/<[^>]*>//g'`
    ENTRY=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count] 2>/dev/null`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$TITLE" | grep -i $query` ]]
    then
        grabvalues
        printvalues
    fi
    count=$((count+1))
done


}

function dsearch {

while [ -n "$ENTRY" ]
do
    echo "Parsing the title of comic $count..."
    TITLE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/title 2>/dev/null | sed -e 's/<[^>]*>//g'`
    ENTRY=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count] 2>/dev/null`
    #Enclose this bit in an if statement that makes sense
    if [[ -n `echo "$TITLE" | grep -i $query` ]]
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
    echo "got the entry"
    TITLE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/title 2>/dev/null | sed -e 's/<[^>]*>//g'`
    echo "got the title"
    NUMBER=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/number 2>/dev/null | sed -e 's/<[^>]*>//g'`
    echo "got the number"
    IMAGELINK=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/imageLink 2>/dev/null | sed -e 's/<[^>]*>//g'`
    echo "got the link"
    TRANSCRIPT=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/transcript 2>/dev/null | sed -e 's/<[^>]*>//g'`
    echo "got the transcript"
    ALTTEXT=`xpath xkcdXMLarchive /comicRoot/entry[$count]/alttext 2>/dev/null | sed -e 's/<[^>]*>//g'`
    echo "got the alt text"
    DATE=`xpath xkcdXMLarchive.xml /comicRoot/entry[$count]/date 2>/dev/null | sed -e 's/<[^>]*>//g'`
    echo "got the date"
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

while getopts ":t:" opt; do
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
