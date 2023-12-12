#! /bin/bash
if [[ ! -d posts ]]; then
    echo "posts/ does not exist. Cannot create site with no posts." >&2
    exit 1
fi

if [[ ! -d site ]]; then
    mkdir site
fi

INDEX="./site/index.html"
cat head.html > $INDEX
for year in posts/* ; do
    mkdir "site/$year"
done
for article in posts/*/*.md ; do
    echo "$article"
    base_name="${article%.md}"
    base_name="${base_name#posts/}"
    html="$base_name.html"
    title=$(head -1 $article | sed -e 's/# //')
    pandoc $article --template=site.template --metadata title="$title" -o "site/$html"
    echo "<li><a href=\"$html\">$title</a></li>" >> $INDEX
done
echo "</ul>" >> $INDEX
cat foot.html >> $INDEX

