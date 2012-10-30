#! /bin/bash
# A basic parser that I grabbed from stackoverflow plus a few of my own additions for our purposes. I imagine it will evolve over the next few serious commits
# Takes three arguments, in this order: [file to parse] [field to parse] [thing to look for formatted for grep]

read_dom () {
    local IFS=\>
        read -d \< ENTITY CONTENT
}

while read_dom; do
    if [[ $ENTITY = $2 ]] ; then
        echo $CONTENT | grep -i $3 && echo "-------------"
    fi
done < $1
