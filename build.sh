#! /bin/bash
if [[ ! -d posts ]]; then
    echo "posts/ does not exist. Cannot create site with no posts." >&2
    exit 1
fi

if [[ ! -d site ]]; then
    mkdir site
fi

INDEX="./site/index.html"
echo "<!DOCTYPE html>" > $INDEX #Overwrite any previous contents
echo "<html lang=\"en-US\">" >> $INDEX
echo "<head>" >> $INDEX
echo "<meta charset=\"utf-8\">" >> $INDEX
echo "<body>" >> $INDEX
echo "<h1>My Blog</h1>" >> $INDEX
echo "<ul>" >> $INDEX
for article in posts/*.md ; do
    base_name="${article%.md}"
    base_name="${base_name#posts/}"
    html="$base_name.html"
    title=$(head -1 $article | sed -e 's/# //')
    if [[ $article -nt "site/$html" ]]; then
        pandoc $article --template=site.template --metadata title="$title" -o "site/$html"
    fi
    echo "<li><a href=\"$html\">$title</a></li>" >> $INDEX
done
echo "</ul>" >> $INDEX
echo "</body" >> $INDEX
echo "</html" >> $INDEX


cd site
python -m http.server 8080


