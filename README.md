# NCBI_rentrez


##  GenBank_rentrez_timeWindow.R
NCBI/Entrez is a molecular biology database system that provides integrated access to nucleotide & protein sequence data, gene-centered and genomic mapping information.

This R script is used to download SARS-CoV-2 fasta sequences from NCBI/nuccore DB using Rentrez from the command line. It download fasta sequences for a specific time window, and for  a specific geographic location (USA/State) defined by the user. 

The user must submmit three arguments: (1): initial time (ie. 220608), 
                                       (2): final time (i.e.: 220820), 
                                       (3): Geographic location where the fasta sequences were submitted, (i.e: TX)


Rscript GenBank_rentrez_window.R  220608  220820  TX
Using these arguments, the SARS-CoV-2 fasta sequences downloaded will be from the state of TX and with sample collection date within 22-06-08 and 22-06-20

This script uses the rentrez R package to query the NCBI's databases: https://cran.r-project.org/web/packages/rentrez/rentrez.pdf

The search, usin rentrez, can uses one or several fields combined using logical operators, for example this script use the following search fields:

#### base<-"HUMAN AND SARS-CoV-2 AND 25000:30000[SLEN] AND “geographic-location" AND COLLECTION_TIME"
- geographic location and sample collection dates must be submitted by the user


##  GenBank_fastas_fromList.R
Usage: R script to download fasta sequences listed in a list from NCBI/nuccore DB using Rentrez from the command line.
       Any number of fastas can be download at once. 
       
ie: Rscript GenBank_fastas_fromList.R list.CSV

List.CVS must contain a header and the GenBank IDs




## GenBank_fastas_Now2back
work in progress,
