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
    metadata="$article|$(head -2 $article | tr '\n' '|' | sed -e 's/# //')"
    echo "$metadata" >> $postlist
    postdate=$(echo $metadata | cut -d '|' -f 3)
    title=$(echo $metadata | cut -d '|' -f 2)
    base_name="${article%.md}"
    html="$base_name.html"
    if [[ $article -nt "site/$html" ]]; then
        pandoc $article --template=site.template --metadata title="$title" -o "site/$html"
    fi
done
echo "<ul>" >> $INDEX
sortedposts=$(mktemp)
sort -t '|' -r -k3 $postlist > "$sortedposts"
cat $sortedposts | sed 's/.md/.html/' | awk -F '|' '{printf("<li><a href=\"%s\">%s %s</a></li>\n", $1, $3, $2)}' >> $INDEX
echo "</ul>" >> $INDEX
cat foot.html >> $INDEX
echo $sortedposts | head -10 | awk 'BEGIN{FS="|"} \
{printf("<entry>\n<title>%s</title>\n<link rel=\"alternate\" type=\"text/html\" href=\"%s\"/>\n",  $1, $2, $3)}' >> /dev/null
rm "$postlist"
rm "$sortedposts"

