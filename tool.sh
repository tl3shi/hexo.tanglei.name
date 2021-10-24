#!/bin/bash
TITLE=
while getopts "t:dpx" opt 
do
    case $opt in
    t)
       TITLE=$OPTARG
       ;;
    d)
        echo "new draft: source/_drafts/$TITLE.md"
        touch "source/_drafts/$TITLE.md"
        echo -e "---\ntitle: $TITLE\nlayout: post\ncategories: \n  - 经验技巧 \ntags: \n  - 经验技巧\n---" >> "source/_drafts/$TITLE.md"
        ;;
    p)
        titlepre=$(date +%Y-%m-%d)
        mv source/_drafts/$TITLE.md source/_posts/$titlepre-$TITLE.md
        echo "publish post: $titlepre-$TITLE.md"
        ;;
    x)
        #curl "qcloud.tanglei.name:1024/go/deploy-hexo/"
        #echo "deploy fired."
        cd public
        git init && git add -A . && git commit -m "commit from local"
        git push --force "https://github.com/tl3shi/hexo.tanglei.name.git" master:gh-pages
        #git push --force "https://gitee.com/tangleithu/hexo.tanglei.name.git" master:gh-pages
        ;;
    *)
        echo "-t \"title\" -d(new drafts) -p(publish post) -x(deploy)"
        ;;
    esac
done
