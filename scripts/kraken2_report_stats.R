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

# Rename the headers
Kraken2_Report  <- setNames(Kraken2_Report , c("read_coverage_percentage", "read_coverage_number", "assigned_read_number", "rank", "NCBI_ID", "Name"))

# Amount and percentage of unclassified reads
unclassified_cov_perc=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$Name=="unclassified")]
classified_cov_perc=100-unclassified_cov_perc

# Total amount of reds and unclassified amount of reads
unclassified_cov_readnum=Kraken2_Report$read_coverage_number[which(Kraken2_Report$Name=="unclassified")]
total_read_number=sum(Kraken2_Report$assigned_read_number)

# Percentage of reads covered under the rank
domain_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="D")])
kingdom_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="K")])
phylum_cov_perct=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="P")])
class_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="C")])
order_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="O")])
family_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="F")])
genuscov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="G")])
species_cov_perc=sum(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank=="S")])

# Give percentage and name for each rank
Rank="F"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
top10_read_cov_perc_family=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
top10_name_family=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

Rank="G"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
top10_read_cov_perc_genus=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
top10_name_genus=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

Rank="S"
order_index=order(Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)],decreasing = TRUE)
top10_read_cov_perc_species=Kraken2_Report$read_coverage_percentage[which(Kraken2_Report$rank==Rank)][order_index][1:10]
top10_name_species=Kraken2_Report$Name[which(Kraken2_Report$rank==Rank)][order_index][1:10]

# Define the output dataframe
output <- data.frame(unclassified_cov_perc,
                     classified_cov_perc,
                     unclassified_cov_readnum,
                     total_read_number,
                     domain_cov_perc,
                     kingdom_cov_perc,
                     phylum_cov_perct,
                     class_cov_perc,
                     order_cov_perc,
                     family_cov_perc,
                     genuscov_perc,
                     species_cov_perc,
                     top10_read_cov_perc_family,
                     top10_name_family,
                     top10_read_cov_perc_genus,
                     top10_name_genus,
                     top10_read_cov_perc_species,
                     top10_name_species, stringsAsFactors=FALSE)


# Save tht data
write.table(output, file = args[2], sep = ",", col.names = NA,
            qmethod = "double")



