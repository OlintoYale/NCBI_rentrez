#/usr/bin/env Rscript
# Author: JLinares/08/2022
#       Usage: Getting fasta sequences from NCBI/GenBank/nuccore from an ID list
#       Parameters: the Ids list. ie: Rscript GenBank_fastas_from_list GenBank_IDS.csv
library("easypackages");libraries("ape","rentrez","stringr","tidyverse")
suppressMessages(libraries(c("lubridate","seqinr")))
options(timeout = 700, "width"=400)

args = commandArgs(trailingOnly=T)
list <-args[1]

Records  = read.csv(list)
Records<-Records$Ids
cat("Wait, donlowding ",length(Records), "fasta sequences from NCBI/GenBank/nuccore DDs","\n")
bigqueryindex <- split(Records,ceiling(seq_along(Records)/200));

SARS2_seq<-vector()
for (i in as.list(bigqueryindex)){
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

cat("Wait, storing ",length(Records), "fasta sequences","\n")
names(seq.fasta) <- str_sub(SARS2_seq[grep(">", SARS2_seq)],2,-1)
seq.fasta <- tibble(label = names(seq.fasta), sequence = seq.fasta)
seq.fasta$len=nchar((seq.fasta$sequence))

write.fasta(as.list(seq.fasta$sequence), names=seq.fasta$label,as.string=T,nbchar = 60,file.out=paste(getwd(),paste("GenBank_",Sys.Date(),".fasta",sep =""),sep="/"))
cat("sequences stored at ",paste(getwd(),paste("GenBank_",Sys.Date(),".fasta",sep =""),sep="/"),"\n")
