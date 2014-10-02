#!/usr/bin/perl

use strict;
use warnings;
use File::MimeInfo;
use URI;

my $file = "data.json";
open my $info, $file or die "Could not open $file: $!";

while( my $line = <$info>)  {   
	if($line =~ m/"([^"]+\.(png|jpg|wav|ogg|gif))"/i ) {
		my $f = $1;
		my $mtype = mimetype($f);
		my $u = URI->new("data:");
		$u->media_type($mtype);
		$u->data(scalar(`cat $f`));
		my $uri = "$u";
		$line =~ s/\Q$f\E/$uri/g;
	}
	print $line;
}

close $info;
