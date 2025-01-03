# SNP-Distance-Matrix-Generator
A script to calculate pairwise SNP distances from a core-genome VCF file and generate a distance matrix with optional simplification. Designed for bioinformatics workflows, this tool provides an easy-to-use interface for analyzing genomic similarities and differences.

## Features
- Calculates pairwise SNP distances between samples in a VCF file.
- Outputs a distance matrix as a CSV file.
- Optionally simplifies the matrix by removing duplicate distances and diagonal entries using the `-simplify` flag.
- Automatically orders samples by their average SNP distances for better pattern visualization.

## Requirements
- R (version 3.5 or higher)
- `vcfR` package (installed automatically if missing)

## Usage
Run the script from the command line:
```
Rscript snps-matrix.R [path to core-vcf] [-simplify (optional)]
```

### Examples
1. **Generate Full Distance Matrix**:
```
Rscript snps-matrix.R core.vcf
```
Output: `distance_matrix_ordered.csv`

2. **Generate Simplified Distance Matrix**:
```
Rscript snps-matrix.R core.vcf -simplify
```
Output: `distance_matrix_simplified.csv`

## Output
- **Rows/Columns**: Sample IDs (from the VCF file).
- **Values**: SNP distances between pairs of samples.
- **Simplified Matrix**: Lower triangle and diagonal entries are replaced with empty cells.

## Contact

For questions or issues, please contact [sb474@st-andrews.ac.uk](mailto:sb474@st-andrews.ac.uk).
