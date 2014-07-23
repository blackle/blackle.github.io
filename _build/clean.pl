#!/usr/bin/perl

use strict;
use warnings;

my $root = '..';

my @folders = map { chomp; $_ } `find * -maxdepth 0 ! -path . -type d  -print`;

foreach my $folder (@folders) {
  print "removing $folder\n";
  my $path = "$root/$folder";
  `rm -rf $path`;
}
