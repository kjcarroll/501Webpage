#! /bin/bash

#Be sure we get the info we need, and not other junk
if [ -z $1 ]; then echo "Reqires the name of your XML file as an argument" && exit 1; fi
if [[ $2 != "" ]]; then echo "Only one argument allowed" && exit 1; fi
if [[ ! -f $1 ]]; then echo "XML file must already exist, run xkcdXMLarchive.sh to make one" && exit 1; fi

#Strip the closing element off of our XML database
sed -i '$ d' $1

#Determine the number of the last comic we have in our file
#This should probably be replaced with an xsl, maybe sometime in the future.

CURNUM="`tac $1 | grep \<number\> | head -n 1 | sed -e 's,.*<number>\([^<]*\)</number>.*,\1,g'`"
MAXNUM="`wget -q -O - http://xkcd.com/info.0.json | jsawk 'return this.num'`"
STARTNUM="`echo "$CURNUM+1" | bc`"

#Grab the entries we don't already have and put them in the XML file

for ((i=$STARTNUM;i<=$MAXNUM;i++))
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

#Reclose our root element
echo -e "</comicRoot>" >> $1
