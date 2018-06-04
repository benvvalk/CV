# Description

This repo contains the source files for my Curriculum Vitae, and instructions for generating the PDF (see below).

# Pregenerated Outputs

As regenerating the PDF always seems to lead to a lot of fiddling with formatting, I have saved pregenerated HTML and PDF outputs in the [pregenerated](pregenerated) directory, as a kindness to my future self.

# Dependencies

* Perl with the following modules:
  * Template
  * constant::boolean
  * XML::Writer
  * BibTeX::Parser
* [wkhtmltopdf](https://wkhtmltopdf.org/) to convert HTML version of CV to PDF.  NB: The last time I generated my CV, I used `wkhtmltopdf` version 0.12.4 from the `Nix` package repository.

# Source Files

* [cv.html.template](cv.html.template): edit this file to update the contents of the CV (e.g. work experience)
* [publications.bib](publications.bib): edit this file to update the list of publications

# Building the HTML and PDF Files

If all the dependencies are installed correctly, you should be able to generate the output HTML and PDF files (`cv.html` and `cv.pdf`) by running:
```
./build.pl
```

# Notes/Acknowledgements

The CSS stylesheets were copied a few years ago from LinkedIn, from its now-defunct "Resume Builder" feature. LinkedIn still has an option to export a user profile as a resume-like PDF, but the functionality is more limited and the CSS stylesheets no longer seem to be publicly accessible.

