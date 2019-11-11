#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_ref
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_combine.%j.out
#SBATCH --output=out_combine.%j.out
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=48


# Written by:	 Ava Hoffman
# Date:		     19 July 2018
# Purpose: 	    combine snps and call genotypes

# purge all existing modules
module purge

# load any modules needed to run your program  
module load jdk/1.8.0

# Set paths
export PATH=$PATH:/projects/hoffmana@colostate.edu/bbmap
export PATH=$PATH:/projects/hoffmana@colostate.edu/2bRAD_utilities/scripts
export PATH=$PATH:/projects/hoffmana@colostate.edu/cd-hit-v4.6.8-2017-1208
export PATH=$PATH:/projects/hoffmana@colostate.edu/standard-RAxML
export PATH=$PATH:/projects/hoffmana@colostate.edu/BGC

###################

# CombineBaseCounts.pl *.tab >combined.tab
# CallGenotypes.pl -i combined.tab -o genotypes.tab -x 0.005 -n 0.15

## save only polymorphic loci
PolyFilter.pl -i /scratch/summit/hoffmana@colostate.edu/genomics/alignment/genotypes_nf.tab -n 2 -p y -o snps.tab

## save only samples with 10000+ loci
## save only loci across 300 samples
## only 4 SNPS in a tag (prevents repetitive sites)
## finally, only one SNP per tag
LowcovSampleFilter.pl -i snps.tab -n 10000 -p y -o samplefiltered.tab
MDFilter.pl -i samplefiltered.tab -n 300 -p y -o mdfiltered.tab
RepTagFilter.pl -i mdfiltered.tab -n 4 -p y -o nr.tab
OneSNPPerTag.pl -i nr.tab -p y -o selected_snps.tab

MDFilter.pl -i samplefiltered.tab -n 40 -p y -o mdfiltered_40.tab
RepTagFilter.pl -i mdfiltered_40.tab -n 4 -p y -o nr_40.tab
OneSNPPerTag.pl -i nr_40.tab -p y -o selected_snps_40.tab