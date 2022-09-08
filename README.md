# NCBI_rentrez


##  GenBank_rentrez_window.R
Usage: R script to download SARS-CoV-2 fasta sequences from NCBI/nuccore DB using rentrez. 
This script download fasta sequences for a specific time window, and for  a specific geographic location (USA/State) defined by the user. 

The user MUST submmit three arguments: (1): to (initial time), (2) tf (final time), (3) Geographic location where the fasta sequences were submitted

i.e: 
#### Rscript GenBank_rentrez_window.R  220608  220820  TX
Using these arguments, the SARS-CoV-2 fasta sequences downloaded will be from the state of TX and with sample collection date within 22-06-08 and 22-06-20

The NCBI uses a search syntax using entrez, (the R package is called Rentrez). Entrez is a molecular biology database system that provides integrated access to nucleotide & protein sequence data, gene-centered and genomic mapping information.

Rentrex.pdf info can be found here: https://cran.r-project.org/web/packages/rentrez/rentrez.pdf

Searches can be make using one or several fields combined using logical operators, for example this script use the following search fields:
#### base<-"HUMAN AND SARS-CoV-2 AND 25000:30000[SLEN] AND “geographic-location" AND COLLECTION_TIME"
- geographic location and sample collection dates must be submitted by the user


### RCovidSummary.R

This script shold be run after the analytics phase and the pangolin-lineage are completed. The script summaryzes the run and generated two files: RCovidseq_summary and RunParameters, that will be stored at the runpath/Rsumcovidseq folder. 

RunParameters: Is the collection of run static parameters: Wetlab assay, instrument type, software, pangolin version, Read Type, Number of Samples, number of Lanes, Chemistry , index adapters and the date of the run.

Rcovidseq-summary: Is the collecton of the dynamic variables  such as: sample_IDs, lineage, scorpion_call, num_actg, num_n, pass/fail.
