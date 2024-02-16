#! /bin/bash
if [[ ! -d posts ]]; then
    echo "posts/ does not exist. Cannot create site with no posts." >&2
    exit 1
fi

if [[ ! -d site ]]; then
    mkdir site
fi

cp -r static/ site/

INDEX="./site/index.html"
cat head.html > $INDEX
postlist=$(mktemp)
for year in posts/* ; do
    mkdir -p "site/$year"
done
for article in posts/*/*.md ; do
    echo "$article"
    echo "$article|$(head -2 $article | tr '\n' '|')" >> "$postlist"
    base_name="${article%.md}"
    html="$base_name.html"
    title=$(head -1 $article | sed -e 's/# //')
    if [[ $article -nt "site/$html" ]]; then
        pandoc $article --template=site.template --metadata title="$title" -o "site/$html"
    fi
    echo "<li><a href=\"$html\">$title</a></li>" >> $INDEX
done
echo "</ul>" >> $INDEX
cat foot.html >> $INDEX
cat $postlist
rm $postlist

