#!/usr/bin/perl
#
# https://grantm.github.io/perl-libxml-by-example/basics.html
# 2024-02-25

# use 5.010;
use strict;
use warnings;

use XML::LibXML;

my $filename = 'playlist.xml';

my $dom = XML::LibXML->load_xml(location => $filename);

foreach my $title ($dom->findnodes('/playlist/movie/title'))
  {
   print $title->to_literal() ."\n" ;
  }
