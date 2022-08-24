#/usr/bin/env Rscript
# Author: JLinares/08/2022
#       Usage: Getting fasta sequences from NCBI/GenBank/nuccore from the previous three months
#       Parameters: 3. 
#       ie: Rscript GenBank_rentrez.R  220607  220820  TX
#.      This example will download SARS-CoV-2 fasta sequences  with sample collection date within 22-06-07 and 22-08-20 and submitted by the State of TX

library("easypackages");libraries("ape","rentrez","lubridate","stringr","seqinr", "tidyverse")
options(timeout = 700, "width"=400)
args = commandArgs(trailingOnly=T)
date1<-ymd(substr(args[1], 1, 6))
date2<-ymd(substr(args[2], 1, 6))
a1<-seq(ymd(date1), ymd(date2), by="days");

base<-paste("HUMAN AND USA AND SARS-CoV-2 AND 25000:30000[SLEN] AND", as.character(args[3]), "AND COLLECTION_DATE=", SEP = "")

cat("Please wait, searching the NCBI/GenBank/nuccore DB for SARS-CoV-2 fasta sequences with collection date within",
    as.character(ymd(date1)),"and",as.character(ymd(date2)), "and submitted by the state of",as.character(args[3]),"\n")

Records<-vector()
for (i in 1:length(a1)){
     tt<-a1[i]
     locus= paste(base,tt,sep = "")
     r_search <- entrez_search(db="nuccore", term=locus)
     Records<-c(Records, r_search$ids)
     }

cat("Please wait, downloading/storing", length(Records), "SARS-CoV-2 fasta sequences","\n")

bigqueryindex <- split(Records,ceiling(seq_along(Records)/200));SARS2_seq<-vector()

for (i in bigqueryindex){
     part_seq<-entrez_fetch(db="nuccore",i,rettype = "fasta")
     part_seq<-unlist(strsplit(part_seq,"\n"))
     SARS2_seq<-c(SARS2_seq,part_seq)
     }

SARS2_seq<-unlist(strsplit(SARS2_seq,"\n"))
header.lines <- grep(">", SARS2_seq)
seq.pos <- cbind(start = grep(">", SARS2_seq) + 1, stop = c(grep(">", SARS2_seq)[-1] - 1, length(SARS2_seq)))
seq.fasta <- apply(seq.pos, 1, function(x){
  paste0(SARS2_seq[ seq(as.numeric(x["start"]), as.numeric(x["stop"])) ], sep = "", collapse = "")
  })

names(seq.fasta) <- str_sub(SARS2_seq[grep(">", SARS2_seq)],2,-1)
seq.fasta <- tibble(label = names(seq.fasta), sequence = seq.fasta)
seq.fasta$len=nchar((seq.fasta$sequence))
write.fasta(as.list(seq.fasta$sequence), names=seq.fasta$label,as.string=T,nbchar = 60,file.out=paste("GenBank_",Sys.Date(),".fasta",sep =""))
cat("sequences stored at ",paste("GenBank_",Sys.Date(),".fasta",sep =""),"\n")
