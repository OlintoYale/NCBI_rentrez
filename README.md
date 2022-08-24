# NCBI_rentrez


##  GenBank_rentrez_window.R
Usage: R script to donwload SARS-CoV-2 fasta sequences from NCBI/nuccore DB using rentrez. This script download fasta sequences for a specific time window, and a specific location (USA/Satate) defined by the user. 

The user MUST submmit three arguments: (1): to (initial time), (2) tf (final time), (3) Geographic location where the fasta sequences were submitted

i.e: 
#### Rscript GenBank_rentrez_window.R  220608  220820  TX
Using these arguments the SARS-CoV-2 fasta sequences downloaded will be from the state of TX and with sample collection date within 22-06-08 and 22-06-20

rentrex.pdf cinfo can be found here: https://cran.r-project.org/web/packages/rentrez/rentrez.pdf

The NCBI uses a search syntax using entrez, (the R package is called Rentrez). Entrez is a molecular biology database system that provides integrated access to nucleotide & protein sequence data, gene-centered and genomic mapping information.

Searches can be make using one or several fields combined using logical operator, for example the script GenBank_rentrez_window.R us the following searcg fields:
base<-HUMAN AND SARS-CoV-2 AND 25000:3000[SLEN] AND  "geographic-location" AND COLLECTION_TIME"
geographic-location must be submitted by the user as well as the collection times.

