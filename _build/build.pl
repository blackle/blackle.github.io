#!/usr/bin/perl

use strict;
use warnings;
use File::Copy;

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
my $root = '..';

sub process_posts { my ($dir) = @_;
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
      my $cover_class = "no-cover";
      if (-e "./$dir/$file/cover.jpg") {
        $cover = "<figure style=\"background-image: url('/$dir/$file/cover.jpg')\" ></figure>";
        $cover_class = "with-cover";
        copy("./$dir/$file/cover.jpg", "$root/$dir/$file/cover.jpg") or die $!;
      }

      my @article_bits = split /\[\[MORE\]\]/, $article;
      my $index_article = $article_bits[0];
      $article = join '', @article_bits;

      $index_article = "<article class=\"index-article $cover_class\">\n$cover\n$index_article\n<a class=\"read-more-link\" href=\"/$dir/$file/\">Read More &rarr;</a>\n</article>\n";
      push @index, $index_article;
      
      my $main_article = "<article class=\"main-article\">\n$cover\n$article\n</article>\n";

      open(ARTICLE_MAIN, ">$root/$dir/$file/index.html") or die $!;
      print ARTICLE_MAIN $HTML_START;
      print ARTICLE_MAIN $main_article;
      print ARTICLE_MAIN $HTML_END;
      close(ARTICLE_MAIN);

  }

  my $index_full = join '', @index;

  open(ARTICLE_INDEX, ">$root/$dir/index.html") or die $!;
  print ARTICLE_INDEX $HTML_START;
  print ARTICLE_INDEX $index_full;
  print ARTICLE_INDEX $HTML_END;
  close(ARTICLE_INDEX);
}

process_posts("projects");

open(INDEX, ">$root/index.html") or die $!;
print INDEX $HTML_START;
# print INDEX "";
print INDEX $HTML_END;
close(INDEX);

`chmod 755 -R $root`;