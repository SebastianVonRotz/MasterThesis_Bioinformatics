# Load libraries


# Load trailing arguments
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

# Show the arguments
print(args[1])
print(args[2])

# Load the data
Kraken2_Report <- read.delim(args[1], header=FALSE,colClasses=c("V6"="character", "V4"="character"))
# Load the data (personal computer)
# Kraken2_Report <- read.delim("C:/Users/voro/OneDrive/9_Studium/MasterThesis/R_scripts/D4/classification_kraken2_raw_sbs_01/BC22.fastq_REPORT", header=FALSE,colClasses=c("V6"="character", "V4"="character"))

# Rename the headers
Kraken2_Report  <- setNames(Kraken2_Report , c("read_coverage_percentage", "read_coverage_number", "assigned_read_number", "rank", "NCBI_ID", "Name"))

# Amount and percentage of unclassified reads
unclassified_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$Name=="unclassified")]
if (length(unclassified_cov_perc)==0){
  unclassified_cov_perc=0
}
classified_cov_perc=100-unclassified_cov_perc

# Total amount of reds and unclassified amount of reads
unclassified_cov_readnum=Kraken2_Report$read_coverage_number[which(Kraken2_Report$Name=="unclassified")]
if (length(unclassified_cov_readnum)==0){
  unclassified_cov_readnum=0
}
total_read_number=sum(Kraken2_Report$assigned_read_number)

# Percentage of reads covered under the rank
d_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="D")])
k_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="K")])
p_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="P")])
c_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="C")])
o_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="O")])
f_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="F")])
g_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="G")])
s_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="S")])

# Give percentage and name for each rank
Rank="D"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
d_T10_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
d_T10_tax_names=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

Rank="K"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
k_T10_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
k_T10_tax_names=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

Rank="P"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
p_T10_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
p_T10_tax_names=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

Rank="C"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
c_T10_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
c_T10_tax_names=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

Rank="O"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
o_T10_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
o_T10_tax_names=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

Rank="F"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
f_T10_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
f_T10_tax_names=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

Rank="G"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
g_T10_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
g_T10_tax_names=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

Rank="S"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
s_T10_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
s_T10_tax_names=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

# Define the output dataframe
output <- data.frame(unclassified_cov_perc,
                     classified_cov_perc,
                     unclassified_cov_readnum,
                     total_read_number,
                     d_cov_perc,
                     k_cov_perc,
                     p_cov_perc,
                     c_cov_perc,
                     o_cov_perc,
                     f_cov_perc,
                     g_cov_perc,
                     s_cov_perc,
                     d_T10_cov_perc,
                     d_T10_tax_names,
                     k_T10_cov_perc,
                     k_T10_tax_names,
                     p_T10_cov_perc,
                     p_T10_tax_names,
                     c_T10_cov_perc,
                     c_T10_tax_names,
                     o_T10_cov_perc,
                     o_T10_tax_names,
                     f_T10_cov_perc,
                     f_T10_tax_names,
                     g_T10_cov_perc,
                     g_T10_tax_names,
                     s_T10_cov_perc,
                     s_T10_tax_names)


# Save tht data
write.table(output, file = args[2], sep = ",", col.names = NA,
            qmethod = "double")



