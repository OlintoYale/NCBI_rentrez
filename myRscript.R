#/usr/bin/env Rscript
# Author: JLinares/08/2022
#       Usage: Getting fasta sequences from NCBI/GenBank/nuccore from the previous three months
#       Parameters: none. ie: Rscript /. . . ./GenBank_rentrez.R 
#library("easypackages");
library("ape")
library("rentrez")
library("lubridate")
library("stringr")
library("seqinr")
library( "tidyverse")
sup <- suppressPackageStartupMessages
library("easypackages");libraries("ape","rentrez","stringr")
sup(library("lubridate"))
sup(library("tidyverse"))
sup(library("seqinr"))
args = commandArgs(trailingOnly=T);
#args[1]<-c('3'); 


options(timeout = 700, "width"=400)
base<-"HUMAN AND UT NOT UPHL AND SARS-CoV-2 AND 25000:30000[SLEN] AND COLLECTION_DATE="
# cat(base)
toff<-3;
# toff<-as.numeric(args[1])
cat(toff)
locus<-paste(base,seq(ymd(Sys.Date())%m+% months(-toff), ymd(Sys.Date()), by="days"),sep="")
cat(locus,"\n")
cat("Please wait, searching the NCBI/GenBank/nuccore DB for SARS-CoV-2 fasta sequences with collection date between ",
    as.character(ymd(Sys.Date())%m+% months(-toff)), "and", as.character(Sys.Date()),",inclusive", "\n")

Records<-vector()
for (i in 1:length(seq(ymd(Sys.Date())%m+% months(-toff), ymd(Sys.Date()), by="days"))){
  r_search <- entrez_search(db="nuccore", term=locus[i])
  Records<-c(Records, r_search$ids)
  cat(r_search$ids,"\n")
}
cat("Please wait, downloading/storing", length(Records), "fasta sequences","\n")
bigqueryindex <- split(Records,ceiling(seq_along(Records)/200));SARS2_seq<-vector()

for (i in bigqueryindex){
  part_seq<-entrez_fetch(db="nuccore",i,rettype = "fasta")
  part_seq<-unlist(strsplit(part_seq,"\n"))
  SARS2_seq<-c(SARS2_seq,part_seq)
  cat(part_seq,"\n")
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
