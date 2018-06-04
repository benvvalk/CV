#!/usr/bin/perl

use strict;
use warnings;

use Template;

my $publications_html = qx{bibtex2html.pl publications.bib};
my $templater = Template->new();
$templater->process(
    'cv.html.template',
    { PUBLICATIONS => $publications_html },
    'cv.html',
);
system('wkhtmltopdf', 'cv.html', 'cv.pdf');
