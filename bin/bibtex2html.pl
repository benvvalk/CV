#!/usr/bin/perl

use strict;
use warnings;

use constant::boolean;
use XML::Writer;
use Data::Dumper;
use BibTeX::Parser;
use IO::File;

my @citations = ();
my $file = IO::File->new($ARGV[0]);
my $parser = BibTeX::Parser->new($file);
while (my $citation = $parser->next) {

    for my $key (keys %$citation) {

        # field values surrounded by double braces will still
        # have one set of braces remaining.  Remove them.

        $citation->{$key} =~ s/^\{(.*)\}$/$1/s;

        # remove escapes that are intended for LaTeX (e.g. "\&", "\_")

        $citation->{$key} =~ s/\\//g;

    }

    push(@citations, $citation);

}

@citations = sort { $b->{year} <=> $a->{year} } @citations;

my $xml = XML::Writer->new(
    UNSAFE => 1,
    DATA_MODE => 1,
    DATA_INDENT => 4,
);

my $first_publication = TRUE;
foreach my $citation (@citations) {
    my @authors = get_authors($citation->{author});

#    print Dumper(@authors);

    $xml->startTag('div', class => ($first_publication ? 'publication first' : 'publication'));
        $xml->startTag('div', class => 'publication-details');
            $xml->startTag('a', href => $citation->{url});
                my $title = $citation->{title};
                $title =~ s/\{(.*)\}/$1/s;
                $xml->characters($title);
            $xml->endTag('a');
            $xml->characters(",");
            $xml->startTag('span', class => 'authors');
                foreach my $author (@authors) {
                    $xml->startTag('span', class => 'author');
                        $xml->characters($author->{first_name});
                        $xml->characters(' ');
                        $xml->characters($author->{last_name});
                        $xml->characters(',');
                    $xml->endTag('span');
                }
            $xml->endTag('span');
            $xml->startTag('span', class => 'publisher');
                $xml->characters($citation->{booktitle} || $citation->{journal});
                $xml->characters('.');
            $xml->endTag('span');
        $xml->endTag('div');
        $xml->startTag('div', class => 'dates');
            $xml->startTag('span', class => 'start-year');
                $xml->characters($citation->{year});
            $xml->endTag('span');
        $xml->endTag('div');
    $xml->endTag('div');
    print "\n";
    $first_publication = FALSE;
}

sub get_authors {
    my $authors_string = shift;
#    printf("authors_string: '%s'\n", $authors_string);
    my @authors = ();
    my @author_strings = split(/\s+and\s+/, $authors_string);
#    print Dumper(@author_strings);
    foreach my $author_string (@author_strings) {
        my ($last, $first) = split(/\s*,\s*/, $author_string);
        # use initial for first name(s)
        $first =~ s/([A-Z])([a-zA-Z]+)/$1./g;
#       printf("first: '%s', last: '%s'\n", $first, $last);
        push(@authors, { first_name => $first, last_name => $last });
    }
    return @authors;
}

sub strip_brackets_or_quotes {
    my $stripped = shift @_;
    $stripped =~ s/\s*\{(.*)\}\s*/$1/s;
    $stripped =~ s/\s*\[(.*)\]\s*/$1/s;
    $stripped =~ s/\s*<(.*)>\s*/$1/s;
    $stripped =~ s/\s*"(.*)"\s*/$1/s;
    $stripped =~ s/\s*'(.*)'\s*/$1/s;
    return $stripped;
}
