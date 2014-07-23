#!/usr/bin/perl

use strict;
use warnings;

open(BASE, "base.html");

my $onpre = 0;

my $HTML_START;
my $HTML_END;

while (<BASE>) {
  my $line = $_;
  if($line =~ m/SPLIT HERE/) {
    $onpre = 1;
  } else {
    if($onpre == 0) {
      $HTML_START .= $line;
    } else {
      $HTML_END .= $line;
    }
  }
}

close(BASE);


my $dir = 'projects';
my $root = '..';
opendir(DIR, "./$dir") or die $!;

mkdir "$root/$dir";

my @index;

while (my $file = readdir(DIR)) {
    next if $file =~ m/^\./;
    mkdir "$root/$dir/$file";
    open(ARTICLE, "./$dir/$file/article.html") or die $!;
    my @lines = <ARTICLE>;
    my $article = join '', @lines;
    close(ARTICLE);

    my $cover = "";
    if (-e "./$dir/$file/cover.jpg") {
      $cover = "<figure style=\"background_image: url('/$dir/$file/cover.jpg')\" ></figure>";
    }

    my @article_bits = split /\[\[MORE\]\]/, $article;
    my $index_article = $article_bits[0];

    $index_article = "<article>\n$cover\n$index_article\n</article>\n";
    push @index, $index_article;
    
    my $main_article = "<article>\n$cover\n$article\n</article>\n";

    open(ARTICLE_MAIN, ">$root/$dir/$file/index.html");
    print ARTICLE_MAIN $HTML_START;
    print ARTICLE_MAIN $main_article;
    print ARTICLE_MAIN $HTML_END;
    close(ARTICLE_MAIN);

    print $index_article;
}

print $/;