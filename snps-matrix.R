#!/usr/bin/env Rscript

# Install and load necessary packages
if (!require("vcfR")) install.packages("vcfR", repos = "http://cran.us.r-project.org")
library(vcfR)

# Parse command-line arguments
args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 1) {
  stop("Usage: Rscript snps-matrix.R [path to core-vcf] [-simplify (optional)]")
}

vcf_file <- args[1]
simplify <- "-simplify" %in% args

# Read VCF file
vcf <- read.vcfR(vcf_file)

# Extract SNP matrix
snp_matrix <- extract.gt(vcf)

# Replace missing values with "N"
snp_matrix[is.na(snp_matrix)] <- "N"

# Create a function for vectorized SNP distance calculation
calculate_snp_distances <- function(matrix) {
  apply(matrix, 2, function(col1) {
    apply(matrix, 2, function(col2) sum(col1 != col2))
  })
}

# Calculate SNP distance matrix
distance_matrix <- calculate_snp_distances(snp_matrix)

# Set row and column names to taxon IDs
taxon_ids <- colnames(snp_matrix)
rownames(distance_matrix) <- taxon_ids
colnames(distance_matrix) <- taxon_ids

# Calculate the average SNP distance for each sample
average_distances <- rowMeans(distance_matrix, na.rm = TRUE)

# Order the matrix based on average distances
order_indices <- order(average_distances)
distance_matrix <- distance_matrix[order_indices, order_indices]

# Optionally simplify the matrix (remove lower triangle and diagonal)
if (simplify) {
  distance_matrix[lower.tri(distance_matrix, diag = TRUE)] <- ""  # Replace with empty string
}

# Save distance matrix to a CSV file
output_file <- ifelse(simplify, "distance_matrix_simplified.csv", "distance_matrix_ordered.csv")
write.csv(distance_matrix, file = output_file, row.names = TRUE, na = "")

cat("SNP distance matrix saved to", output_file, "\n")
