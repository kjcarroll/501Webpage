#!/bin/bash

#Requires jsawk and wget, other than that I think the rest of these are fairly standard GNU utils than everyone should have...
#I could probably get rid of the wget dep and just use curl, but wheres the fun in that?

MAXNUM="`wget -q -O - http://xkcd.com/info.0.json | jsawk 'return this.num'`"
echo -ne "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<comicRoot>\n"
for ((i=1;i<=$MAXNUM;i++))
    do
        JSON="`wget -qO- http://xkcd.com/$i/info.0.json`"
        TITLE=`echo $JSON | jsawk 'return this.safe_title'`
        NUMBER=`echo $JSON | jsawk 'return this.num'`
        LINK=`echo $JSON | jsawk 'return this.img'`
        TRANSCRIPT=`echo $JSON | jsawk 'return this.transcript'`
        DATE=`echo $JSON | jsawk 'return this.month + "/" + this.day + "/" + this.year'`
        #Scrub transcripts and titles for <,>, and &
        #THIS IS STILL VERY SLOPPY
        TRANSCRIPT=`echo $TRANSCRIPT | sed 's/</\&lt;/g'`
        TRANSCRIPT=`echo $TRANSCRIPT | sed 's/>/\&gt;/g'`
        TRANSCRIPT=`echo $TRANSCRIPT | sed 's/&/\&amp;/g'`
        TITLE=`echo $TITLE | sed 's/</\&lt;/g'`
        TITLE=`echo $TITLE | sed 's/>/\&gt;/g'`
        TITLE=`echo $TITLE | sed 's/&/\&amp;/g'`
        echo -e "\t<entry>\n\t\t<title>$TITLE</title>\n\t\t<number>$NUMBER</number>\n\t\t<imageLink>$LINK</imageLink>\n\t\t<transcript>$TRANSCRIPT</transcript>\n\t\t<date>$DATE</date>\n\t</entry>"
    done
echo -e "</comicRoot>"
