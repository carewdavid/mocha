#! /bin/perl
use v5.38;
use utf8;
use warnings;
use strict;

my $FEED = './site/feed.xml';
my $BASE_URL = 'https://dcarew.com/';
my $TODAY = `date +%F`;

while(<STDIN>){
    chomp;
    s/.md/.html/;
    my ($path, $title, $date) = split(/\|/);
    my $url = $BASE_URL . $path;
    say "<entry>";
    say "<title>$title</title>";
    say "<published>$date</published>";
    say "<id>$url</id>";
    say "link rel=\"alternate\" type=\"text/html\" href=\"$url\"/>";
    say "<content>";
    say `awk '/<body>/,/<\\/body>/' site/$path | sed 's/body>/article>/'`;
    say "</content>";
    say "</entry>";
}
