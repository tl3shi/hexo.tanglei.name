#!/bin/bash
TITLE=
while getopts "t:dp" opt 
do
    case $opt in
    t)
       TITLE=$OPTARG
       ;;
    d)
        echo "new draft: $TITLE.md"
        touch "source/_drafts/$TITLE.md"
        echo -e "---\ntitle: $TITLE\nlayout: post\ncategories: \n  - default\ntags: \n  - MyLife\n---" >> "source/_drafts/$TITLE.md"
        ;;
    p)
        titlepre=$(date +%Y-%m-%d)
        mv source/_drafts/$TITLE.md source/_posts/$titlepre-$TITLE.md
        echo "publish post: $titlepre-$TITLE.md"
        ;;
    *)
        echo "-t \"title\" -d(new drafts) -p(publish post)"
        ;;
    esac
done
