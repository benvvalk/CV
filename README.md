# Description

This repo contains the source files for my Curriculum Vitae, and instructions for generating the PDF (see below).

# Pregenerated Outputs

As regenerating the PDF always seems to lead to a lot of fiddling with formatting, I have saved pregenerated HTML and PDF outputs in the `pregenerated` dir as a kindness to my future self.

# Dependencies

* Perl with the following modules:
  * Template
  * constant::boolean
  * XML::Writer
  * BibTeX::Parser
* (wkhtmltopdf)[https://wkhtmltopdf.org/] to convert HTML version of CV to PDF.  The last time I generated my CV, I used `wkhtmltopdf` version 0.12.4 from the `Nix` package manager.

# Source Files

* [cv.html.template]: edit this file to update the contents of the CV (e.g. work experience)
* [publications.bib]: edit this file to update the list of publications

# Building the PDF

If all the dependencies are installed correctly, you should be able to generate the HTML and PDF files (`cv.html` and `cv.pdf`) by running:
```
./build.pl
```
