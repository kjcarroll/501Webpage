#!/bin/bash

#Requires jsawk and wget, other than that I think the rest of these are fairly standard GNU utils than everyone should have...
#I could probably get rid of the wget dep and just use curl, but wheres the fun in that?

#Be sure we get the info we need, and not other junk
if [ -z $1 ]; then echo "Reqires the name of your XML file as an argument" && exit 1; fi
if [[ $2 != "" ]]; then echo "Only one argument allowed" && exit 1; fi

#DANGER
if [ -a $1 ]; then echo "It looks like $1 already exists. Manually move or rename it to recreate a database under that name" && exit 1; fi

MAXNUM="`wget -q -O - http://xkcd.com/info.0.json | jsawk 'return this.num'`"
echo -ne "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<comicRoot>\n" > $1
for ((i=1;i<=$MAXNUM;i++))
    do
        JSON="`wget -qO- http://xkcd.com/$i/info.0.json`"
        TITLE=`echo $JSON | jsawk 'return this.safe_title'`
        NUMBER=`echo $JSON | jsawk 'return this.num'`
        LINK=`echo $JSON | jsawk 'return this.img'`
        TRANSCRIPT=`echo $JSON | jsawk 'return this.transcript'`
        DATE=`echo $JSON | jsawk 'return this.month + "/" + this.day + "/" + this.year'`
        #Split the transcript into real transcript and alt-text
        TRANSSPLIT=`echo $TRANSCRIPT | awk 'BEGIN { FS = "{{" } ; { print $1 }'`
        #Shy of ideal, grabs whatever they CALLED the alt text too
        ALTSPLIT=`echo $TRANSCRIPT | sed -e 's,.*{{\([^{{]*\)}}.*,\1,g'`
        #Scrub transcripts, alt text, and titles for <,>, and &
        #THIS IS STILL VERY SLOPPY

        TRANSSPLIT=`echo $TRANSSPLIT | sed 's/</\&lt;/g'`
        TRANSSPLIT=`echo $TRANSSPLIT | sed 's/>/\&gt;/g'`
        TRANSSPLIT=`echo $TRANSSPLIT | sed 's/&/\&amp;/g'`

        ALTSPLIT=`echo $ALTSPLIT | sed 's/</\&lt;/g'`
        ALTSPLIT=`echo $ALTSPLIT | sed 's/>/\&gt;/g'`
        ALTSPLIT=`echo $ALTSPLIT | sed 's/&/\&amp;/g'`

        TITLE=`echo $TITLE | sed 's/</\&lt;/g'`
        TITLE=`echo $TITLE | sed 's/>/\&gt;/g'`
        TITLE=`echo $TITLE | sed 's/&/\&amp;/g'`
        echo -e "\t<entry>\n\t\t<title>$TITLE</title>\n\t\t<number>$NUMBER</number>\n\t\t<imageLink>$LINK</imageLink>\n\t\t<transcript>$TRANSSPLIT</transcript>\n\t\t<alttext>$ALTSPLIT</alttext>\n\t\t<date>$DATE</date>\n\t</entry>" >> $1
    done
echo -e "</comicRoot>" >> $1
