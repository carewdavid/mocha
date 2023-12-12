for fname in posts/*.md; do
    l=$(head -1 $fname | sed -e 's/# //')
    echo $l
done
