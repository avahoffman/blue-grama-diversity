#!/bin/bash


#SBATCH --time=24:00:00
#SBATCH --job-name=Bg_
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=error_bg.%j.out
#SBATCH --output=out_bg.%j.out
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=1


# Written by:	 Ava Hoffman
# Date:		     19 July 2018
# Purpose: 	    make a normalized expression matrix

# purge all existing modules
module purge

# load any modules needed to run your program  
module load jdk/1.8.0

# Set paths
export PATH=$PATH:/projects/hoffmana@colostate.edu/bbmap
export PATH=$PATH:/projects/hoffmana@colostate.edu/2bRAD_utilities/scripts
export PATH=$PATH:/home/hoffmana@colostate.edu/perl5/lib/perl5/x86_64-linux/
export PATH=$PATH:/perl5/lib/perl5/x86_64-linux/

#############

## truncate, quality filter, and filter for adaptor sequences
## truncate step is quite fast, but quality filter may take 0.5-2+ hrs per sample!!

# TruncateFastq.pl -i BOGR_A01_S68_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A01_S68_T.fastq
# TruncateFastq.pl -i BOGR_A02_S69_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A02_S69_T.fastq
# TruncateFastq.pl -i BOGR_A03_S70_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A03_S70_T.fastq
# TruncateFastq.pl -i BOGR_A04_S71_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A04_S71_T.fastq
# TruncateFastq.pl -i BOGR_A05_S72_L001_R1_001.fastq -s 1 -e 36 -o BOGR_A05_S72_T.fastq
# TruncateFastq.pl -i BOGR_K01_S18_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K01_S18_T.fastq
# TruncateFastq.pl -i BOGR_K02_S19_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K02_S19_T.fastq
# TruncateFastq.pl -i BOGR_K03_S20_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K03_S20_T.fastq
# TruncateFastq.pl -i BOGR_K04_S21_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K04_S21_T.fastq
# TruncateFastq.pl -i BOGR_K05_S22_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K05_S22_T.fastq
# TruncateFastq.pl -i BOGR_K06_S23_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K06_S23_T.fastq
# TruncateFastq.pl -i BOGR_K07_S24_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K07_S24_T.fastq
# TruncateFastq.pl -i BOGR_K08_S25_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K08_S25_T.fastq
# TruncateFastq.pl -i BOGR_K09_S26_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K09_S26_T.fastq
# TruncateFastq.pl -i BOGR_K10_S27_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K10_S27_T.fastq
# TruncateFastq.pl -i BOGR_K11_S28_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K11_S28_T.fastq
# TruncateFastq.pl -i BOGR_K12_S29_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K12_S29_T.fastq
# TruncateFastq.pl -i BOGR_K13_S30_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K13_S30_T.fastq
# TruncateFastq.pl -i BOGR_K14_S31_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K14_S31_T.fastq
# TruncateFastq.pl -i BOGR_K15_S32_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K15_S32_T.fastq
# TruncateFastq.pl -i BOGR_K16_S33_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K16_S33_T.fastq
# TruncateFastq.pl -i BOGR_K17_S34_L001_R1_001.fastq -s 1 -e 36 -o BOGR_K17_S34_T.fastq
# TruncateFastq.pl -i BOGR_RM01_S35_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM01_S35_T.fastq
# TruncateFastq.pl -i BOGR_RM02_S36_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM02_S36_T.fastq
# TruncateFastq.pl -i BOGR_RM03_S37_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM03_S37_T.fastq
# TruncateFastq.pl -i BOGR_RM04_S38_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM04_S38_T.fastq
# TruncateFastq.pl -i BOGR_RM05_S39_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM05_S39_T.fastq
# TruncateFastq.pl -i BOGR_RM06_S40_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM06_S40_T.fastq
# TruncateFastq.pl -i BOGR_RM07_S41_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM07_S41_T.fastq
# TruncateFastq.pl -i BOGR_RM08_S42_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM08_S42_T.fastq
# TruncateFastq.pl -i BOGR_RM09_S43_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM09_S43_T.fastq
# TruncateFastq.pl -i BOGR_RM10_S44_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM10_S44_T.fastq
# TruncateFastq.pl -i BOGR_RM11_S45_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM11_S45_T.fastq
# TruncateFastq.pl -i BOGR_RM12_S46_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM12_S46_T.fastq
# TruncateFastq.pl -i BOGR_RM13_S47_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM13_S47_T.fastq
# TruncateFastq.pl -i BOGR_RM14_S48_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM14_S48_T.fastq
# TruncateFastq.pl -i BOGR_RM15_S49_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM15_S49_T.fastq
# TruncateFastq.pl -i BOGR_RM16_S50_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM16_S50_T.fastq
# TruncateFastq.pl -i BOGR_RM17_S51_L001_R1_001.fastq -s 1 -e 36 -o BOGR_RM17_S51_T.fastq
# TruncateFastq.pl -i BOGR_W01_S52_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W01_S52_T.fastq
# TruncateFastq.pl -i BOGR_W02_S53_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W02_S53_T.fastq
# TruncateFastq.pl -i BOGR_W03_S54_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W03_S54_T.fastq
# TruncateFastq.pl -i BOGR_W04_S55_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W04_S55_T.fastq
# TruncateFastq.pl -i BOGR_W05_S56_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W05_S56_T.fastq
# TruncateFastq.pl -i BOGR_W06_S57_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W06_S57_T.fastq
# TruncateFastq.pl -i BOGR_W07_S58_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W07_S58_T.fastq
# TruncateFastq.pl -i BOGR_W08_S59_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W08_S59_T.fastq
# TruncateFastq.pl -i BOGR_W09_S60_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W09_S60_T.fastq
# TruncateFastq.pl -i BOGR_W10_S61_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W10_S61_T.fastq
# TruncateFastq.pl -i BOGR_W11_S62_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W11_S62_T.fastq
# TruncateFastq.pl -i BOGR_W12_S63_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W12_S63_T.fastq
# TruncateFastq.pl -i BOGR_W13_S64_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W13_S64_T.fastq
# TruncateFastq.pl -i BOGR_W14_S65_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W14_S65_T.fastq
# TruncateFastq.pl -i BOGR_W15_S66_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W15_S66_T.fastq
# TruncateFastq.pl -i BOGR_W16_S67_L001_R1_001.fastq -s 1 -e 36 -o BOGR_W16_S67_T.fastq
# TruncateFastq.pl -i BOGR_WR01_S1_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR01_S1_T.fastq
# TruncateFastq.pl -i BOGR_WR02_S2_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR02_S2_T.fastq
# TruncateFastq.pl -i BOGR_WR03_S3_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR03_S3_T.fastq
# TruncateFastq.pl -i BOGR_WR04_S4_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR04_S4_T.fastq
# TruncateFastq.pl -i BOGR_WR05_S5_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR05_S5_T.fastq
# TruncateFastq.pl -i BOGR_WR06_S6_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR06_S6_T.fastq
# TruncateFastq.pl -i BOGR_WR07_S7_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR07_S7_T.fastq
# TruncateFastq.pl -i BOGR_WR08_S8_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR08_S8_T.fastq
# TruncateFastq.pl -i BOGR_WR09_S9_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR09_S9_T.fastq
# TruncateFastq.pl -i BOGR_WR10_S10_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR10_S10_T.fastq
# TruncateFastq.pl -i BOGR_WR11_S11_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR11_S11_T.fastq
# TruncateFastq.pl -i BOGR_WR12_S12_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR12_S12_T.fastq
# TruncateFastq.pl -i BOGR_WR13_S13_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR13_S13_T.fastq
# TruncateFastq.pl -i BOGR_WR14_S14_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR14_S14_T.fastq
# TruncateFastq.pl -i BOGR_WR15_S15_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR15_S15_T.fastq
# TruncateFastq.pl -i BOGR_WR16_S16_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR16_S16_T.fastq
# TruncateFastq.pl -i BOGR_WR17_S17_L001_R1_001.fastq -s 1 -e 36 -o BOGR_WR17_S17_T.fastq
# TruncateFastq.pl -i BOGR_A06_S73_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A06_S73_T.fastq
# TruncateFastq.pl -i BOGR_A07_S74_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A07_S74_T.fastq
# TruncateFastq.pl -i BOGR_A08_S75_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A08_S75_T.fastq
# TruncateFastq.pl -i BOGR_A09_S76_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A09_S76_T.fastq
# TruncateFastq.pl -i BOGR_A10_S77_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A10_S77_T.fastq
# TruncateFastq.pl -i BOGR_A11_S78_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A11_S78_T.fastq
# TruncateFastq.pl -i BOGR_A12_S79_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A12_S79_T.fastq
# TruncateFastq.pl -i BOGR_A13_S80_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A13_S80_T.fastq
# TruncateFastq.pl -i BOGR_A14_S81_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A14_S81_T.fastq
# TruncateFastq.pl -i BOGR_A15_S82_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A15_S82_T.fastq
# TruncateFastq.pl -i BOGR_A16_S83_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A16_S83_T.fastq
# TruncateFastq.pl -i BOGR_A17_S84_L002_R1_001.fastq -s 1 -e 36 -o BOGR_A17_S84_T.fastq
# TruncateFastq.pl -i BOGR_DM01_S118_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM01_S118_T.fastq
# TruncateFastq.pl -i BOGR_DM02_S119_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM02_S119_T.fastq
# TruncateFastq.pl -i BOGR_DM03_S120_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM03_S120_T.fastq
# TruncateFastq.pl -i BOGR_DM04_S121_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM04_S121_T.fastq
# TruncateFastq.pl -i BOGR_DM05_S122_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM05_S122_T.fastq
# TruncateFastq.pl -i BOGR_DM06_S123_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM06_S123_T.fastq
# TruncateFastq.pl -i BOGR_DM07_S124_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM07_S124_T.fastq
# TruncateFastq.pl -i BOGR_DM08_S125_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM08_S125_T.fastq
# TruncateFastq.pl -i BOGR_DM09_S126_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM09_S126_T.fastq
# TruncateFastq.pl -i BOGR_DM10_S127_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM10_S127_T.fastq
# TruncateFastq.pl -i BOGR_DM11_S128_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM11_S128_T.fastq
# TruncateFastq.pl -i BOGR_DM12_S129_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM12_S129_T.fastq
# TruncateFastq.pl -i BOGR_DM13_S130_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM13_S130_T.fastq
# TruncateFastq.pl -i BOGR_DM14_S131_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM14_S131_T.fastq
# TruncateFastq.pl -i BOGR_DM15_S132_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM15_S132_T.fastq
# TruncateFastq.pl -i BOGR_DM16_S133_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM16_S133_T.fastq
# TruncateFastq.pl -i BOGR_DM17_S134_L002_R1_001.fastq -s 1 -e 36 -o BOGR_DM17_S134_T.fastq
# TruncateFastq.pl -i BOGR_HV01_S102_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV01_S102_T.fastq
# TruncateFastq.pl -i BOGR_HV02_S103_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV02_S103_T.fastq
# TruncateFastq.pl -i BOGR_HV03_S104_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV03_S104_T.fastq
# TruncateFastq.pl -i BOGR_HV04_S105_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV04_S105_T.fastq
# TruncateFastq.pl -i BOGR_HV05_S106_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV05_S106_T.fastq
# TruncateFastq.pl -i BOGR_HV06_S107_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV06_S107_T.fastq
# TruncateFastq.pl -i BOGR_HV07_S108_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV07_S108_T.fastq
# TruncateFastq.pl -i BOGR_HV08_S109_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV08_S109_T.fastq
# TruncateFastq.pl -i BOGR_HV10_S110_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV10_S110_T.fastq
# TruncateFastq.pl -i BOGR_HV11_S111_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV11_S111_T.fastq
# TruncateFastq.pl -i BOGR_HV12_S112_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV12_S112_T.fastq
# TruncateFastq.pl -i BOGR_HV13_S113_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV13_S113_T.fastq
# TruncateFastq.pl -i BOGR_HV14_S114_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV14_S114_T.fastq
# TruncateFastq.pl -i BOGR_HV15_S115_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV15_S115_T.fastq
# TruncateFastq.pl -i BOGR_HV16_S116_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV16_S116_T.fastq
# TruncateFastq.pl -i BOGR_HV17_S117_L002_R1_001.fastq -s 1 -e 36 -o BOGR_HV17_S117_T.fastq
# TruncateFastq.pl -i BOGR_RC01_S135_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC01_S135_T.fastq
# TruncateFastq.pl -i BOGR_RC02_S136_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC02_S136_T.fastq
# TruncateFastq.pl -i BOGR_RC03_S137_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC03_S137_T.fastq
# TruncateFastq.pl -i BOGR_RC04_S138_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC04_S138_T.fastq
# TruncateFastq.pl -i BOGR_RC05_S139_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC05_S139_T.fastq
# TruncateFastq.pl -i BOGR_RC06_S140_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC06_S140_T.fastq
# TruncateFastq.pl -i BOGR_RC07_S141_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC07_S141_T.fastq
# TruncateFastq.pl -i BOGR_RC08_S142_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC08_S142_T.fastq
# TruncateFastq.pl -i BOGR_RC09_S143_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC09_S143_T.fastq
# TruncateFastq.pl -i BOGR_RC10_S144_L002_R1_001.fastq -s 1 -e 36 -o BOGR_RC10_S144_T.fastq
# TruncateFastq.pl -i BOGR_SGS01_S85_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS01_S85_T.fastq
# TruncateFastq.pl -i BOGR_SGS02_S86_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS02_S86_T.fastq
# TruncateFastq.pl -i BOGR_SGS03_S87_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS03_S87_T.fastq
# TruncateFastq.pl -i BOGR_SGS04_S88_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS04_S88_T.fastq
# TruncateFastq.pl -i BOGR_SGS05_S89_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS05_S89_T.fastq
# TruncateFastq.pl -i BOGR_SGS06_S90_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS06_S90_T.fastq
# TruncateFastq.pl -i BOGR_SGS07_S91_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS07_S91_T.fastq
# TruncateFastq.pl -i BOGR_SGS08_S92_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS08_S92_T.fastq
# TruncateFastq.pl -i BOGR_SGS09_S93_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS09_S93_T.fastq
# TruncateFastq.pl -i BOGR_SGS10_S94_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS10_S94_T.fastq
# TruncateFastq.pl -i BOGR_SGS11_S95_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS11_S95_T.fastq
# TruncateFastq.pl -i BOGR_SGS12_S96_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS12_S96_T.fastq
# TruncateFastq.pl -i BOGR_SGS13_S97_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS13_S97_T.fastq
# TruncateFastq.pl -i BOGR_SGS14_S98_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS14_S98_T.fastq
# TruncateFastq.pl -i BOGR_SGS15_S99_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS15_S99_T.fastq
# TruncateFastq.pl -i BOGR_SGS16_S100_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS16_S100_T.fastq
# TruncateFastq.pl -i BOGR_SGS17_S101_L002_R1_001.fastq -s 1 -e 36 -o BOGR_SGS17_S101_T.fastq
# TruncateFastq.pl -i BOGR_BG01_S203_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG01_S203_T.fastq
# TruncateFastq.pl -i BOGR_BG02_S204_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG02_S204_T.fastq
# TruncateFastq.pl -i BOGR_BG03_S205_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG03_S205_T.fastq
# TruncateFastq.pl -i BOGR_BG04_S206_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG04_S206_T.fastq
# TruncateFastq.pl -i BOGR_BG05_S207_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG05_S207_T.fastq
# TruncateFastq.pl -i BOGR_BG06_S208_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG06_S208_T.fastq
# TruncateFastq.pl -i BOGR_BG07_S209_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG07_S209_T.fastq
# TruncateFastq.pl -i BOGR_BG08_S210_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG08_S210_T.fastq
# TruncateFastq.pl -i BOGR_BG09_S211_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG09_S211_T.fastq
# TruncateFastq.pl -i BOGR_BG10_S212_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG10_S212_T.fastq
# TruncateFastq.pl -i BOGR_BG11_S213_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG11_S213_T.fastq
# TruncateFastq.pl -i BOGR_BG12_S214_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG12_S214_T.fastq
# TruncateFastq.pl -i BOGR_BG13_S215_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG13_S215_T.fastq
# TruncateFastq.pl -i BOGR_BG14_S216_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BG14_S216_T.fastq
# TruncateFastq.pl -i BOGR_BT01_S169_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT01_S169_T.fastq
# TruncateFastq.pl -i BOGR_BT02_S170_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT02_S170_T.fastq
# TruncateFastq.pl -i BOGR_BT03_S171_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT03_S171_T.fastq
# TruncateFastq.pl -i BOGR_BT04_S172_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT04_S172_T.fastq
# TruncateFastq.pl -i BOGR_BT05_S173_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT05_S173_T.fastq
# TruncateFastq.pl -i BOGR_BT06_S174_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT06_S174_T.fastq
# TruncateFastq.pl -i BOGR_BT07_S175_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT07_S175_T.fastq
# TruncateFastq.pl -i BOGR_BT08_S176_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT08_S176_T.fastq
# TruncateFastq.pl -i BOGR_BT09_S177_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT09_S177_T.fastq
# TruncateFastq.pl -i BOGR_BT10_S178_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT10_S178_T.fastq
# TruncateFastq.pl -i BOGR_BT11_S179_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT11_S179_T.fastq
# TruncateFastq.pl -i BOGR_BT12_S180_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT12_S180_T.fastq
# TruncateFastq.pl -i BOGR_BT13_S181_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT13_S181_T.fastq
# TruncateFastq.pl -i BOGR_BT14_S182_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT14_S182_T.fastq
# TruncateFastq.pl -i BOGR_BT15_S183_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT15_S183_T.fastq
# TruncateFastq.pl -i BOGR_BT16_S184_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT16_S184_T.fastq
# TruncateFastq.pl -i BOGR_BT17_S185_L003_R1_001.fastq -s 1 -e 36 -o BOGR_BT17_S185_T.fastq
# TruncateFastq.pl -i BOGR_CO01_S186_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO01_S186_T.fastq
# TruncateFastq.pl -i BOGR_CO02_S187_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO02_S187_T.fastq
# TruncateFastq.pl -i BOGR_CO03_S188_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO03_S188_T.fastq
# TruncateFastq.pl -i BOGR_CO04_S189_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO04_S189_T.fastq
# TruncateFastq.pl -i BOGR_CO05_S190_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO05_S190_T.fastq
# TruncateFastq.pl -i BOGR_CO06_S191_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO06_S191_T.fastq
# TruncateFastq.pl -i BOGR_CO07_S192_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO07_S192_T.fastq
# TruncateFastq.pl -i BOGR_CO08_S193_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO08_S193_T.fastq
# TruncateFastq.pl -i BOGR_CO09_S194_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO09_S194_T.fastq
# TruncateFastq.pl -i BOGR_CO10_S195_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO10_S195_T.fastq
# TruncateFastq.pl -i BOGR_CO11_S196_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO11_S196_T.fastq
# TruncateFastq.pl -i BOGR_CO12_S197_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO12_S197_T.fastq
# TruncateFastq.pl -i BOGR_CO13_S198_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO13_S198_T.fastq
# TruncateFastq.pl -i BOGR_CO14_S199_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO14_S199_T.fastq
# TruncateFastq.pl -i BOGR_CO15_S200_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO15_S200_T.fastq
# TruncateFastq.pl -i BOGR_CO16_S201_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO16_S201_T.fastq
# TruncateFastq.pl -i BOGR_CO17_S202_L003_R1_001.fastq -s 1 -e 36 -o BOGR_CO17_S202_T.fastq
# TruncateFastq.pl -i BOGR_RC11_S145_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC11_S145_T.fastq
# TruncateFastq.pl -i BOGR_RC12_S146_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC12_S146_T.fastq
# TruncateFastq.pl -i BOGR_RC13_S147_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC13_S147_T.fastq
# TruncateFastq.pl -i BOGR_RC14_S148_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC14_S148_T.fastq
# TruncateFastq.pl -i BOGR_RC15_S149_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC15_S149_T.fastq
# TruncateFastq.pl -i BOGR_RC16_S150_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC16_S150_T.fastq
# TruncateFastq.pl -i BOGR_RC17_S151_L003_R1_001.fastq -s 1 -e 36 -o BOGR_RC17_S151_T.fastq
# TruncateFastq.pl -i BOGR_ST01_S152_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST01_S152_T.fastq
# TruncateFastq.pl -i BOGR_ST02_S153_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST02_S153_T.fastq
# TruncateFastq.pl -i BOGR_ST03_S154_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST03_S154_T.fastq
# TruncateFastq.pl -i BOGR_ST04_S155_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST04_S155_T.fastq
# TruncateFastq.pl -i BOGR_ST05_S156_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST05_S156_T.fastq
# TruncateFastq.pl -i BOGR_ST06_S157_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST06_S157_T.fastq
# TruncateFastq.pl -i BOGR_ST07_S158_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST07_S158_T.fastq
# TruncateFastq.pl -i BOGR_ST08_S159_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST08_S159_T.fastq
# TruncateFastq.pl -i BOGR_ST09_S160_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST09_S160_T.fastq
# TruncateFastq.pl -i BOGR_ST10_S161_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST10_S161_T.fastq
# TruncateFastq.pl -i BOGR_ST11_S162_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST11_S162_T.fastq
# TruncateFastq.pl -i BOGR_ST12_S163_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST12_S163_T.fastq
# TruncateFastq.pl -i BOGR_ST13_S164_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST13_S164_T.fastq
# TruncateFastq.pl -i BOGR_ST14_S165_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST14_S165_T.fastq
# TruncateFastq.pl -i BOGR_ST15_S166_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST15_S166_T.fastq
# TruncateFastq.pl -i BOGR_ST16_S167_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST16_S167_T.fastq
# TruncateFastq.pl -i BOGR_ST17_S168_L003_R1_001.fastq -s 1 -e 36 -o BOGR_ST17_S168_T.fastq
# TruncateFastq.pl -i BOGR_BG15_S217_L004_R1_001.fastq -s 1 -e 36 -o BOGR_BG15_S217_T.fastq
# TruncateFastq.pl -i BOGR_BG16_S218_L004_R1_001.fastq -s 1 -e 36 -o BOGR_BG16_S218_T.fastq
# TruncateFastq.pl -i BOGR_BG17_S219_L004_R1_001.fastq -s 1 -e 36 -o BOGR_BG17_S219_T.fastq
# TruncateFastq.pl -i BOGR_CI01_S237_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI01_S237_T.fastq
# TruncateFastq.pl -i BOGR_CI02_S238_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI02_S238_T.fastq
# TruncateFastq.pl -i BOGR_CI03_S239_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI03_S239_T.fastq
# TruncateFastq.pl -i BOGR_CI04_S240_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI04_S240_T.fastq
# TruncateFastq.pl -i BOGR_CI05_S241_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI05_S241_T.fastq
# TruncateFastq.pl -i BOGR_CI06_S242_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI06_S242_T.fastq
# TruncateFastq.pl -i BOGR_CI07_S243_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI07_S243_T.fastq
# TruncateFastq.pl -i BOGR_CI08_S244_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI08_S244_T.fastq
# TruncateFastq.pl -i BOGR_CI09_S245_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI09_S245_T.fastq
# TruncateFastq.pl -i BOGR_CI10_S246_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI10_S246_T.fastq
# TruncateFastq.pl -i BOGR_CI11_S247_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI11_S247_T.fastq
# TruncateFastq.pl -i BOGR_CI12_S248_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI12_S248_T.fastq
# TruncateFastq.pl -i BOGR_CI13_S249_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI13_S249_T.fastq
# TruncateFastq.pl -i BOGR_CI14_S250_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI14_S250_T.fastq
# TruncateFastq.pl -i BOGR_CI15_S251_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI15_S251_T.fastq
# TruncateFastq.pl -i BOGR_CI16_S252_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI16_S252_T.fastq
# TruncateFastq.pl -i BOGR_CI17_S253_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CI17_S253_T.fastq
# TruncateFastq.pl -i BOGR_CP01_S271_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP01_S271_T.fastq
# TruncateFastq.pl -i BOGR_CP02_S272_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP02_S272_T.fastq
# TruncateFastq.pl -i BOGR_CP03_S273_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP03_S273_T.fastq
# TruncateFastq.pl -i BOGR_CP04_S274_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP04_S274_T.fastq
# TruncateFastq.pl -i BOGR_CP05_S275_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP05_S275_T.fastq
# TruncateFastq.pl -i BOGR_CP06_S276_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP06_S276_T.fastq
# TruncateFastq.pl -i BOGR_CP07_S277_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP07_S277_T.fastq
# TruncateFastq.pl -i BOGR_CP08_S278_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP08_S278_T.fastq
# TruncateFastq.pl -i BOGR_CP09_S279_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP09_S279_T.fastq
# TruncateFastq.pl -i BOGR_CP10_S280_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP10_S280_T.fastq
# TruncateFastq.pl -i BOGR_CP11_S281_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP11_S281_T.fastq
# TruncateFastq.pl -i BOGR_CP12_S282_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP12_S282_T.fastq
# TruncateFastq.pl -i BOGR_CP13_S283_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP13_S283_T.fastq
# TruncateFastq.pl -i BOGR_CP14_S284_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP14_S284_T.fastq
# TruncateFastq.pl -i BOGR_CP15_S285_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP15_S285_T.fastq
# TruncateFastq.pl -i BOGR_CP16_S286_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP16_S286_T.fastq
# TruncateFastq.pl -i BOGR_CP17_S287_L004_R1_001.fastq -s 1 -e 36 -o BOGR_CP17_S287_T.fastq
# TruncateFastq.pl -i BOGR_KNZ01_S254_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ01_S254_T.fastq
# TruncateFastq.pl -i BOGR_KNZ02_S255_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ02_S255_T.fastq
# TruncateFastq.pl -i BOGR_KNZ03_S256_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ03_S256_T.fastq
# TruncateFastq.pl -i BOGR_KNZ04_S257_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ04_S257_T.fastq
# TruncateFastq.pl -i BOGR_KNZ05_S258_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ05_S258_T.fastq
# TruncateFastq.pl -i BOGR_KNZ06_S259_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ06_S259_T.fastq
# TruncateFastq.pl -i BOGR_KNZ07_S260_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ07_S260_T.fastq
# TruncateFastq.pl -i BOGR_KNZ08_S261_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ08_S261_T.fastq
# TruncateFastq.pl -i BOGR_KNZ09_S262_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ09_S262_T.fastq
# TruncateFastq.pl -i BOGR_KNZ10_S263_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ10_S263_T.fastq
# TruncateFastq.pl -i BOGR_KNZ11_S264_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ11_S264_T.fastq
# TruncateFastq.pl -i BOGR_KNZ12_S265_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ12_S265_T.fastq
# TruncateFastq.pl -i BOGR_KNZ13_S266_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ13_S266_T.fastq
# TruncateFastq.pl -i BOGR_KNZ14_S267_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ14_S267_T.fastq
# TruncateFastq.pl -i BOGR_KNZ15_S268_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ15_S268_T.fastq
# TruncateFastq.pl -i BOGR_KNZ16_S269_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ16_S269_T.fastq
# TruncateFastq.pl -i BOGR_KNZ17_S270_L004_R1_001.fastq -s 1 -e 36 -o BOGR_KNZ17_S270_T.fastq
# TruncateFastq.pl -i BOGR_SEV01_S220_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV01_S220_T.fastq
# TruncateFastq.pl -i BOGR_SEV02_S221_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV02_S221_T.fastq
# TruncateFastq.pl -i BOGR_SEV03_S222_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV03_S222_T.fastq
# TruncateFastq.pl -i BOGR_SEV04_S223_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV04_S223_T.fastq
# TruncateFastq.pl -i BOGR_SEV05_S224_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV05_S224_T.fastq
# TruncateFastq.pl -i BOGR_SEV06_S225_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV06_S225_T.fastq
# TruncateFastq.pl -i BOGR_SEV07_S226_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV07_S226_T.fastq
# TruncateFastq.pl -i BOGR_SEV08_S227_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV08_S227_T.fastq
# TruncateFastq.pl -i BOGR_SEV09_S228_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV09_S228_T.fastq
# TruncateFastq.pl -i BOGR_SEV10_S229_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV10_S229_T.fastq
# TruncateFastq.pl -i BOGR_SEV11_S230_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV11_S230_T.fastq
# TruncateFastq.pl -i BOGR_SEV12_S231_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV12_S231_T.fastq
# TruncateFastq.pl -i BOGR_SEV13_S232_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV13_S232_T.fastq
# TruncateFastq.pl -i BOGR_SEV14_S233_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV14_S233_T.fastq
# TruncateFastq.pl -i BOGR_SEV15_S234_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV15_S234_T.fastq
# TruncateFastq.pl -i BOGR_SEV16_S235_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV16_S235_T.fastq
# TruncateFastq.pl -i BOGR_SEV17_S236_L004_R1_001.fastq -s 1 -e 36 -o BOGR_SEV17_S236_T.fastq

# QualFilterFastq.pl -i BOGR_A01_S68_T.fastq -m 20 -x 4 -o BOGR_A01_S68_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A02_S69_T.fastq -m 20 -x 4 -o BOGR_A02_S69_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A03_S70_T.fastq -m 20 -x 4 -o BOGR_A03_S70_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A04_S71_T.fastq -m 20 -x 4 -o BOGR_A04_S71_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A05_S72_T.fastq -m 20 -x 4 -o BOGR_A05_S72_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K01_S18_T.fastq -m 20 -x 4 -o BOGR_K01_S18_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K02_S19_T.fastq -m 20 -x 4 -o BOGR_K02_S19_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K03_S20_T.fastq -m 20 -x 4 -o BOGR_K03_S20_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K04_S21_T.fastq -m 20 -x 4 -o BOGR_K04_S21_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K05_S22_T.fastq -m 20 -x 4 -o BOGR_K05_S22_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K06_S23_T.fastq -m 20 -x 4 -o BOGR_K06_S23_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K07_S24_T.fastq -m 20 -x 4 -o BOGR_K07_S24_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K08_S25_T.fastq -m 20 -x 4 -o BOGR_K08_S25_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K09_S26_T.fastq -m 20 -x 4 -o BOGR_K09_S26_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K10_S27_T.fastq -m 20 -x 4 -o BOGR_K10_S27_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K11_S28_T.fastq -m 20 -x 4 -o BOGR_K11_S28_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K12_S29_T.fastq -m 20 -x 4 -o BOGR_K12_S29_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K13_S30_T.fastq -m 20 -x 4 -o BOGR_K13_S30_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K14_S31_T.fastq -m 20 -x 4 -o BOGR_K14_S31_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K15_S32_T.fastq -m 20 -x 4 -o BOGR_K15_S32_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K16_S33_T.fastq -m 20 -x 4 -o BOGR_K16_S33_T_Q.fastq
# QualFilterFastq.pl -i BOGR_K17_S34_T.fastq -m 20 -x 4 -o BOGR_K17_S34_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM01_S35_T.fastq -m 20 -x 4 -o BOGR_RM01_S35_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM02_S36_T.fastq -m 20 -x 4 -o BOGR_RM02_S36_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM03_S37_T.fastq -m 20 -x 4 -o BOGR_RM03_S37_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM04_S38_T.fastq -m 20 -x 4 -o BOGR_RM04_S38_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM05_S39_T.fastq -m 20 -x 4 -o BOGR_RM05_S39_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM06_S40_T.fastq -m 20 -x 4 -o BOGR_RM06_S40_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM07_S41_T.fastq -m 20 -x 4 -o BOGR_RM07_S41_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM08_S42_T.fastq -m 20 -x 4 -o BOGR_RM08_S42_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM09_S43_T.fastq -m 20 -x 4 -o BOGR_RM09_S43_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM10_S44_T.fastq -m 20 -x 4 -o BOGR_RM10_S44_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM11_S45_T.fastq -m 20 -x 4 -o BOGR_RM11_S45_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM12_S46_T.fastq -m 20 -x 4 -o BOGR_RM12_S46_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM13_S47_T.fastq -m 20 -x 4 -o BOGR_RM13_S47_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM14_S48_T.fastq -m 20 -x 4 -o BOGR_RM14_S48_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM15_S49_T.fastq -m 20 -x 4 -o BOGR_RM15_S49_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM16_S50_T.fastq -m 20 -x 4 -o BOGR_RM16_S50_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RM17_S51_T.fastq -m 20 -x 4 -o BOGR_RM17_S51_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W01_S52_T.fastq -m 20 -x 4 -o BOGR_W01_S52_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W02_S53_T.fastq -m 20 -x 4 -o BOGR_W02_S53_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W03_S54_T.fastq -m 20 -x 4 -o BOGR_W03_S54_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W04_S55_T.fastq -m 20 -x 4 -o BOGR_W04_S55_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W05_S56_T.fastq -m 20 -x 4 -o BOGR_W05_S56_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W06_S57_T.fastq -m 20 -x 4 -o BOGR_W06_S57_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W07_S58_T.fastq -m 20 -x 4 -o BOGR_W07_S58_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W08_S59_T.fastq -m 20 -x 4 -o BOGR_W08_S59_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W09_S60_T.fastq -m 20 -x 4 -o BOGR_W09_S60_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W10_S61_T.fastq -m 20 -x 4 -o BOGR_W10_S61_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W11_S62_T.fastq -m 20 -x 4 -o BOGR_W11_S62_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W12_S63_T.fastq -m 20 -x 4 -o BOGR_W12_S63_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W13_S64_T.fastq -m 20 -x 4 -o BOGR_W13_S64_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W14_S65_T.fastq -m 20 -x 4 -o BOGR_W14_S65_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W15_S66_T.fastq -m 20 -x 4 -o BOGR_W15_S66_T_Q.fastq
# QualFilterFastq.pl -i BOGR_W16_S67_T.fastq -m 20 -x 4 -o BOGR_W16_S67_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR01_S1_T.fastq -m 20 -x 4 -o BOGR_WR01_S1_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR02_S2_T.fastq -m 20 -x 4 -o BOGR_WR02_S2_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR03_S3_T.fastq -m 20 -x 4 -o BOGR_WR03_S3_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR04_S4_T.fastq -m 20 -x 4 -o BOGR_WR04_S4_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR05_S5_T.fastq -m 20 -x 4 -o BOGR_WR05_S5_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR06_S6_T.fastq -m 20 -x 4 -o BOGR_WR06_S6_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR07_S7_T.fastq -m 20 -x 4 -o BOGR_WR07_S7_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR08_S8_T.fastq -m 20 -x 4 -o BOGR_WR08_S8_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR09_S9_T.fastq -m 20 -x 4 -o BOGR_WR09_S9_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR10_S10_T.fastq -m 20 -x 4 -o BOGR_WR10_S10_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR11_S11_T.fastq -m 20 -x 4 -o BOGR_WR11_S11_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR12_S12_T.fastq -m 20 -x 4 -o BOGR_WR12_S12_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR13_S13_T.fastq -m 20 -x 4 -o BOGR_WR13_S13_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR14_S14_T.fastq -m 20 -x 4 -o BOGR_WR14_S14_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR15_S15_T.fastq -m 20 -x 4 -o BOGR_WR15_S15_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR16_S16_T.fastq -m 20 -x 4 -o BOGR_WR16_S16_T_Q.fastq
# QualFilterFastq.pl -i BOGR_WR17_S17_T.fastq -m 20 -x 4 -o BOGR_WR17_S17_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A06_S73_T.fastq -m 20 -x 4 -o BOGR_A06_S73_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A07_S74_T.fastq -m 20 -x 4 -o BOGR_A07_S74_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A08_S75_T.fastq -m 20 -x 4 -o BOGR_A08_S75_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A09_S76_T.fastq -m 20 -x 4 -o BOGR_A09_S76_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A10_S77_T.fastq -m 20 -x 4 -o BOGR_A10_S77_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A11_S78_T.fastq -m 20 -x 4 -o BOGR_A11_S78_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A12_S79_T.fastq -m 20 -x 4 -o BOGR_A12_S79_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A13_S80_T.fastq -m 20 -x 4 -o BOGR_A13_S80_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A14_S81_T.fastq -m 20 -x 4 -o BOGR_A14_S81_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A15_S82_T.fastq -m 20 -x 4 -o BOGR_A15_S82_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A16_S83_T.fastq -m 20 -x 4 -o BOGR_A16_S83_T_Q.fastq
# QualFilterFastq.pl -i BOGR_A17_S84_T.fastq -m 20 -x 4 -o BOGR_A17_S84_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM01_S118_T.fastq -m 20 -x 4 -o BOGR_DM01_S118_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM02_S119_T.fastq -m 20 -x 4 -o BOGR_DM02_S119_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM03_S120_T.fastq -m 20 -x 4 -o BOGR_DM03_S120_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM04_S121_T.fastq -m 20 -x 4 -o BOGR_DM04_S121_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM05_S122_T.fastq -m 20 -x 4 -o BOGR_DM05_S122_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM06_S123_T.fastq -m 20 -x 4 -o BOGR_DM06_S123_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM07_S124_T.fastq -m 20 -x 4 -o BOGR_DM07_S124_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM08_S125_T.fastq -m 20 -x 4 -o BOGR_DM08_S125_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM09_S126_T.fastq -m 20 -x 4 -o BOGR_DM09_S126_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM10_S127_T.fastq -m 20 -x 4 -o BOGR_DM10_S127_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM11_S128_T.fastq -m 20 -x 4 -o BOGR_DM11_S128_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM12_S129_T.fastq -m 20 -x 4 -o BOGR_DM12_S129_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM13_S130_T.fastq -m 20 -x 4 -o BOGR_DM13_S130_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM14_S131_T.fastq -m 20 -x 4 -o BOGR_DM14_S131_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM15_S132_T.fastq -m 20 -x 4 -o BOGR_DM15_S132_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM16_S133_T.fastq -m 20 -x 4 -o BOGR_DM16_S133_T_Q.fastq
# QualFilterFastq.pl -i BOGR_DM17_S134_T.fastq -m 20 -x 4 -o BOGR_DM17_S134_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV01_S102_T.fastq -m 20 -x 4 -o BOGR_HV01_S102_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV02_S103_T.fastq -m 20 -x 4 -o BOGR_HV02_S103_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV03_S104_T.fastq -m 20 -x 4 -o BOGR_HV03_S104_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV04_S105_T.fastq -m 20 -x 4 -o BOGR_HV04_S105_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV05_S106_T.fastq -m 20 -x 4 -o BOGR_HV05_S106_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV06_S107_T.fastq -m 20 -x 4 -o BOGR_HV06_S107_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV07_S108_T.fastq -m 20 -x 4 -o BOGR_HV07_S108_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV08_S109_T.fastq -m 20 -x 4 -o BOGR_HV08_S109_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV10_S110_T.fastq -m 20 -x 4 -o BOGR_HV10_S110_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV11_S111_T.fastq -m 20 -x 4 -o BOGR_HV11_S111_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV12_S112_T.fastq -m 20 -x 4 -o BOGR_HV12_S112_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV13_S113_T.fastq -m 20 -x 4 -o BOGR_HV13_S113_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV14_S114_T.fastq -m 20 -x 4 -o BOGR_HV14_S114_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV15_S115_T.fastq -m 20 -x 4 -o BOGR_HV15_S115_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV16_S116_T.fastq -m 20 -x 4 -o BOGR_HV16_S116_T_Q.fastq
# QualFilterFastq.pl -i BOGR_HV17_S117_T.fastq -m 20 -x 4 -o BOGR_HV17_S117_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC01_S135_T.fastq -m 20 -x 4 -o BOGR_RC01_S135_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC02_S136_T.fastq -m 20 -x 4 -o BOGR_RC02_S136_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC03_S137_T.fastq -m 20 -x 4 -o BOGR_RC03_S137_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC04_S138_T.fastq -m 20 -x 4 -o BOGR_RC04_S138_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC05_S139_T.fastq -m 20 -x 4 -o BOGR_RC05_S139_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC06_S140_T.fastq -m 20 -x 4 -o BOGR_RC06_S140_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC07_S141_T.fastq -m 20 -x 4 -o BOGR_RC07_S141_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC08_S142_T.fastq -m 20 -x 4 -o BOGR_RC08_S142_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC09_S143_T.fastq -m 20 -x 4 -o BOGR_RC09_S143_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC10_S144_T.fastq -m 20 -x 4 -o BOGR_RC10_S144_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS01_S85_T.fastq -m 20 -x 4 -o BOGR_SGS01_S85_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS02_S86_T.fastq -m 20 -x 4 -o BOGR_SGS02_S86_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS03_S87_T.fastq -m 20 -x 4 -o BOGR_SGS03_S87_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS04_S88_T.fastq -m 20 -x 4 -o BOGR_SGS04_S88_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS05_S89_T.fastq -m 20 -x 4 -o BOGR_SGS05_S89_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS06_S90_T.fastq -m 20 -x 4 -o BOGR_SGS06_S90_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS07_S91_T.fastq -m 20 -x 4 -o BOGR_SGS07_S91_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS08_S92_T.fastq -m 20 -x 4 -o BOGR_SGS08_S92_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS09_S93_T.fastq -m 20 -x 4 -o BOGR_SGS09_S93_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS10_S94_T.fastq -m 20 -x 4 -o BOGR_SGS10_S94_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS11_S95_T.fastq -m 20 -x 4 -o BOGR_SGS11_S95_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS12_S96_T.fastq -m 20 -x 4 -o BOGR_SGS12_S96_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS13_S97_T.fastq -m 20 -x 4 -o BOGR_SGS13_S97_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS14_S98_T.fastq -m 20 -x 4 -o BOGR_SGS14_S98_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS15_S99_T.fastq -m 20 -x 4 -o BOGR_SGS15_S99_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS16_S100_T.fastq -m 20 -x 4 -o BOGR_SGS16_S100_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SGS17_S101_T.fastq -m 20 -x 4 -o BOGR_SGS17_S101_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG01_S203_T.fastq -m 20 -x 4 -o BOGR_BG01_S203_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG02_S204_T.fastq -m 20 -x 4 -o BOGR_BG02_S204_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG03_S205_T.fastq -m 20 -x 4 -o BOGR_BG03_S205_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG04_S206_T.fastq -m 20 -x 4 -o BOGR_BG04_S206_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG05_S207_T.fastq -m 20 -x 4 -o BOGR_BG05_S207_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG06_S208_T.fastq -m 20 -x 4 -o BOGR_BG06_S208_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG07_S209_T.fastq -m 20 -x 4 -o BOGR_BG07_S209_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG08_S210_T.fastq -m 20 -x 4 -o BOGR_BG08_S210_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG09_S211_T.fastq -m 20 -x 4 -o BOGR_BG09_S211_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG10_S212_T.fastq -m 20 -x 4 -o BOGR_BG10_S212_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG11_S213_T.fastq -m 20 -x 4 -o BOGR_BG11_S213_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG12_S214_T.fastq -m 20 -x 4 -o BOGR_BG12_S214_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG13_S215_T.fastq -m 20 -x 4 -o BOGR_BG13_S215_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG14_S216_T.fastq -m 20 -x 4 -o BOGR_BG14_S216_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT01_S169_T.fastq -m 20 -x 4 -o BOGR_BT01_S169_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT02_S170_T.fastq -m 20 -x 4 -o BOGR_BT02_S170_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT03_S171_T.fastq -m 20 -x 4 -o BOGR_BT03_S171_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT04_S172_T.fastq -m 20 -x 4 -o BOGR_BT04_S172_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT05_S173_T.fastq -m 20 -x 4 -o BOGR_BT05_S173_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT06_S174_T.fastq -m 20 -x 4 -o BOGR_BT06_S174_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT07_S175_T.fastq -m 20 -x 4 -o BOGR_BT07_S175_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT08_S176_T.fastq -m 20 -x 4 -o BOGR_BT08_S176_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT09_S177_T.fastq -m 20 -x 4 -o BOGR_BT09_S177_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT10_S178_T.fastq -m 20 -x 4 -o BOGR_BT10_S178_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT11_S179_T.fastq -m 20 -x 4 -o BOGR_BT11_S179_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT12_S180_T.fastq -m 20 -x 4 -o BOGR_BT12_S180_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT13_S181_T.fastq -m 20 -x 4 -o BOGR_BT13_S181_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT14_S182_T.fastq -m 20 -x 4 -o BOGR_BT14_S182_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT15_S183_T.fastq -m 20 -x 4 -o BOGR_BT15_S183_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT16_S184_T.fastq -m 20 -x 4 -o BOGR_BT16_S184_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BT17_S185_T.fastq -m 20 -x 4 -o BOGR_BT17_S185_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO01_S186_T.fastq -m 20 -x 4 -o BOGR_CO01_S186_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO02_S187_T.fastq -m 20 -x 4 -o BOGR_CO02_S187_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO03_S188_T.fastq -m 20 -x 4 -o BOGR_CO03_S188_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO04_S189_T.fastq -m 20 -x 4 -o BOGR_CO04_S189_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO05_S190_T.fastq -m 20 -x 4 -o BOGR_CO05_S190_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO06_S191_T.fastq -m 20 -x 4 -o BOGR_CO06_S191_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO07_S192_T.fastq -m 20 -x 4 -o BOGR_CO07_S192_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO08_S193_T.fastq -m 20 -x 4 -o BOGR_CO08_S193_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO09_S194_T.fastq -m 20 -x 4 -o BOGR_CO09_S194_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO10_S195_T.fastq -m 20 -x 4 -o BOGR_CO10_S195_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO11_S196_T.fastq -m 20 -x 4 -o BOGR_CO11_S196_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO12_S197_T.fastq -m 20 -x 4 -o BOGR_CO12_S197_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO13_S198_T.fastq -m 20 -x 4 -o BOGR_CO13_S198_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO14_S199_T.fastq -m 20 -x 4 -o BOGR_CO14_S199_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO15_S200_T.fastq -m 20 -x 4 -o BOGR_CO15_S200_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO16_S201_T.fastq -m 20 -x 4 -o BOGR_CO16_S201_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CO17_S202_T.fastq -m 20 -x 4 -o BOGR_CO17_S202_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC11_S145_T.fastq -m 20 -x 4 -o BOGR_RC11_S145_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC12_S146_T.fastq -m 20 -x 4 -o BOGR_RC12_S146_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC13_S147_T.fastq -m 20 -x 4 -o BOGR_RC13_S147_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC14_S148_T.fastq -m 20 -x 4 -o BOGR_RC14_S148_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC15_S149_T.fastq -m 20 -x 4 -o BOGR_RC15_S149_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC16_S150_T.fastq -m 20 -x 4 -o BOGR_RC16_S150_T_Q.fastq
# QualFilterFastq.pl -i BOGR_RC17_S151_T.fastq -m 20 -x 4 -o BOGR_RC17_S151_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST01_S152_T.fastq -m 20 -x 4 -o BOGR_ST01_S152_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST02_S153_T.fastq -m 20 -x 4 -o BOGR_ST02_S153_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST03_S154_T.fastq -m 20 -x 4 -o BOGR_ST03_S154_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST04_S155_T.fastq -m 20 -x 4 -o BOGR_ST04_S155_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST05_S156_T.fastq -m 20 -x 4 -o BOGR_ST05_S156_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST06_S157_T.fastq -m 20 -x 4 -o BOGR_ST06_S157_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST07_S158_T.fastq -m 20 -x 4 -o BOGR_ST07_S158_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST08_S159_T.fastq -m 20 -x 4 -o BOGR_ST08_S159_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST09_S160_T.fastq -m 20 -x 4 -o BOGR_ST09_S160_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST10_S161_T.fastq -m 20 -x 4 -o BOGR_ST10_S161_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST11_S162_T.fastq -m 20 -x 4 -o BOGR_ST11_S162_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST12_S163_T.fastq -m 20 -x 4 -o BOGR_ST12_S163_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST13_S164_T.fastq -m 20 -x 4 -o BOGR_ST13_S164_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST14_S165_T.fastq -m 20 -x 4 -o BOGR_ST14_S165_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST15_S166_T.fastq -m 20 -x 4 -o BOGR_ST15_S166_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST16_S167_T.fastq -m 20 -x 4 -o BOGR_ST16_S167_T_Q.fastq
# QualFilterFastq.pl -i BOGR_ST17_S168_T.fastq -m 20 -x 4 -o BOGR_ST17_S168_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG15_S217_T.fastq -m 20 -x 4 -o BOGR_BG15_S217_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG16_S218_T.fastq -m 20 -x 4 -o BOGR_BG16_S218_T_Q.fastq
# QualFilterFastq.pl -i BOGR_BG17_S219_T.fastq -m 20 -x 4 -o BOGR_BG17_S219_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI01_S237_T.fastq -m 20 -x 4 -o BOGR_CI01_S237_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI02_S238_T.fastq -m 20 -x 4 -o BOGR_CI02_S238_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI03_S239_T.fastq -m 20 -x 4 -o BOGR_CI03_S239_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI04_S240_T.fastq -m 20 -x 4 -o BOGR_CI04_S240_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI05_S241_T.fastq -m 20 -x 4 -o BOGR_CI05_S241_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI06_S242_T.fastq -m 20 -x 4 -o BOGR_CI06_S242_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI07_S243_T.fastq -m 20 -x 4 -o BOGR_CI07_S243_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI08_S244_T.fastq -m 20 -x 4 -o BOGR_CI08_S244_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI09_S245_T.fastq -m 20 -x 4 -o BOGR_CI09_S245_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI10_S246_T.fastq -m 20 -x 4 -o BOGR_CI10_S246_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI11_S247_T.fastq -m 20 -x 4 -o BOGR_CI11_S247_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI12_S248_T.fastq -m 20 -x 4 -o BOGR_CI12_S248_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI13_S249_T.fastq -m 20 -x 4 -o BOGR_CI13_S249_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI14_S250_T.fastq -m 20 -x 4 -o BOGR_CI14_S250_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI15_S251_T.fastq -m 20 -x 4 -o BOGR_CI15_S251_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI16_S252_T.fastq -m 20 -x 4 -o BOGR_CI16_S252_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CI17_S253_T.fastq -m 20 -x 4 -o BOGR_CI17_S253_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP01_S271_T.fastq -m 20 -x 4 -o BOGR_CP01_S271_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP02_S272_T.fastq -m 20 -x 4 -o BOGR_CP02_S272_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP03_S273_T.fastq -m 20 -x 4 -o BOGR_CP03_S273_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP04_S274_T.fastq -m 20 -x 4 -o BOGR_CP04_S274_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP05_S275_T.fastq -m 20 -x 4 -o BOGR_CP05_S275_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP06_S276_T.fastq -m 20 -x 4 -o BOGR_CP06_S276_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP07_S277_T.fastq -m 20 -x 4 -o BOGR_CP07_S277_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP08_S278_T.fastq -m 20 -x 4 -o BOGR_CP08_S278_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP09_S279_T.fastq -m 20 -x 4 -o BOGR_CP09_S279_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP10_S280_T.fastq -m 20 -x 4 -o BOGR_CP10_S280_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP11_S281_T.fastq -m 20 -x 4 -o BOGR_CP11_S281_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP12_S282_T.fastq -m 20 -x 4 -o BOGR_CP12_S282_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP13_S283_T.fastq -m 20 -x 4 -o BOGR_CP13_S283_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP14_S284_T.fastq -m 20 -x 4 -o BOGR_CP14_S284_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP15_S285_T.fastq -m 20 -x 4 -o BOGR_CP15_S285_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP16_S286_T.fastq -m 20 -x 4 -o BOGR_CP16_S286_T_Q.fastq
# QualFilterFastq.pl -i BOGR_CP17_S287_T.fastq -m 20 -x 4 -o BOGR_CP17_S287_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ01_S254_T.fastq -m 20 -x 4 -o BOGR_KNZ01_S254_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ02_S255_T.fastq -m 20 -x 4 -o BOGR_KNZ02_S255_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ03_S256_T.fastq -m 20 -x 4 -o BOGR_KNZ03_S256_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ04_S257_T.fastq -m 20 -x 4 -o BOGR_KNZ04_S257_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ05_S258_T.fastq -m 20 -x 4 -o BOGR_KNZ05_S258_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ06_S259_T.fastq -m 20 -x 4 -o BOGR_KNZ06_S259_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ07_S260_T.fastq -m 20 -x 4 -o BOGR_KNZ07_S260_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ08_S261_T.fastq -m 20 -x 4 -o BOGR_KNZ08_S261_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ09_S262_T.fastq -m 20 -x 4 -o BOGR_KNZ09_S262_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ10_S263_T.fastq -m 20 -x 4 -o BOGR_KNZ10_S263_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ11_S264_T.fastq -m 20 -x 4 -o BOGR_KNZ11_S264_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ12_S265_T.fastq -m 20 -x 4 -o BOGR_KNZ12_S265_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ13_S266_T.fastq -m 20 -x 4 -o BOGR_KNZ13_S266_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ14_S267_T.fastq -m 20 -x 4 -o BOGR_KNZ14_S267_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ15_S268_T.fastq -m 20 -x 4 -o BOGR_KNZ15_S268_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ16_S269_T.fastq -m 20 -x 4 -o BOGR_KNZ16_S269_T_Q.fastq
# QualFilterFastq.pl -i BOGR_KNZ17_S270_T.fastq -m 20 -x 4 -o BOGR_KNZ17_S270_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV01_S220_T.fastq -m 20 -x 4 -o BOGR_SEV01_S220_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV02_S221_T.fastq -m 20 -x 4 -o BOGR_SEV02_S221_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV03_S222_T.fastq -m 20 -x 4 -o BOGR_SEV03_S222_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV04_S223_T.fastq -m 20 -x 4 -o BOGR_SEV04_S223_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV05_S224_T.fastq -m 20 -x 4 -o BOGR_SEV05_S224_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV06_S225_T.fastq -m 20 -x 4 -o BOGR_SEV06_S225_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV07_S226_T.fastq -m 20 -x 4 -o BOGR_SEV07_S226_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV08_S227_T.fastq -m 20 -x 4 -o BOGR_SEV08_S227_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV09_S228_T.fastq -m 20 -x 4 -o BOGR_SEV09_S228_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV10_S229_T.fastq -m 20 -x 4 -o BOGR_SEV10_S229_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV11_S230_T.fastq -m 20 -x 4 -o BOGR_SEV11_S230_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV12_S231_T.fastq -m 20 -x 4 -o BOGR_SEV12_S231_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV13_S232_T.fastq -m 20 -x 4 -o BOGR_SEV13_S232_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV14_S233_T.fastq -m 20 -x 4 -o BOGR_SEV14_S233_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV15_S234_T.fastq -m 20 -x 4 -o BOGR_SEV15_S234_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV16_S235_T.fastq -m 20 -x 4 -o BOGR_SEV16_S235_T_Q.fastq
# QualFilterFastq.pl -i BOGR_SEV17_S236_T.fastq -m 20 -x 4 -o BOGR_SEV17_S236_T_Q.fastq

# bbduk.sh in=BOGR_A01_S68_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A01_S68.txt out=BOGR_A01_S68_T_Q_A.fastq
# bbduk.sh in=BOGR_A02_S69_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A02_S69.txt out=BOGR_A02_S69_T_Q_A.fastq
# bbduk.sh in=BOGR_A03_S70_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A03_S70.txt out=BOGR_A03_S70_T_Q_A.fastq
# bbduk.sh in=BOGR_A04_S71_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A04_S71.txt out=BOGR_A04_S71_T_Q_A.fastq
# bbduk.sh in=BOGR_A05_S72_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A05_S72.txt out=BOGR_A05_S72_T_Q_A.fastq
# bbduk.sh in=BOGR_K01_S18_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K01_S18.txt out=BOGR_K01_S18_T_Q_A.fastq
# bbduk.sh in=BOGR_K02_S19_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K02_S19.txt out=BOGR_K02_S19_T_Q_A.fastq
# bbduk.sh in=BOGR_K03_S20_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K03_S20.txt out=BOGR_K03_S20_T_Q_A.fastq
# bbduk.sh in=BOGR_K04_S21_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K04_S21.txt out=BOGR_K04_S21_T_Q_A.fastq
# bbduk.sh in=BOGR_K05_S22_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K05_S22.txt out=BOGR_K05_S22_T_Q_A.fastq
# bbduk.sh in=BOGR_K06_S23_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K06_S23.txt out=BOGR_K06_S23_T_Q_A.fastq
# bbduk.sh in=BOGR_K07_S24_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K07_S24.txt out=BOGR_K07_S24_T_Q_A.fastq
# bbduk.sh in=BOGR_K08_S25_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K08_S25.txt out=BOGR_K08_S25_T_Q_A.fastq
# bbduk.sh in=BOGR_K09_S26_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K09_S26.txt out=BOGR_K09_S26_T_Q_A.fastq
# bbduk.sh in=BOGR_K10_S27_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K10_S27.txt out=BOGR_K10_S27_T_Q_A.fastq
# bbduk.sh in=BOGR_K11_S28_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K11_S28.txt out=BOGR_K11_S28_T_Q_A.fastq
# bbduk.sh in=BOGR_K12_S29_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K12_S29.txt out=BOGR_K12_S29_T_Q_A.fastq
# bbduk.sh in=BOGR_K13_S30_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K13_S30.txt out=BOGR_K13_S30_T_Q_A.fastq
# bbduk.sh in=BOGR_K14_S31_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K14_S31.txt out=BOGR_K14_S31_T_Q_A.fastq
# bbduk.sh in=BOGR_K15_S32_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K15_S32.txt out=BOGR_K15_S32_T_Q_A.fastq
# bbduk.sh in=BOGR_K16_S33_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K16_S33.txt out=BOGR_K16_S33_T_Q_A.fastq
# bbduk.sh in=BOGR_K17_S34_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_K17_S34.txt out=BOGR_K17_S34_T_Q_A.fastq
# bbduk.sh in=BOGR_RM01_S35_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM01_S35.txt out=BOGR_RM01_S35_T_Q_A.fastq
# bbduk.sh in=BOGR_RM02_S36_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM02_S36.txt out=BOGR_RM02_S36_T_Q_A.fastq
# bbduk.sh in=BOGR_RM03_S37_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM03_S37.txt out=BOGR_RM03_S37_T_Q_A.fastq
# bbduk.sh in=BOGR_RM04_S38_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM04_S38.txt out=BOGR_RM04_S38_T_Q_A.fastq
# bbduk.sh in=BOGR_RM05_S39_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM05_S39.txt out=BOGR_RM05_S39_T_Q_A.fastq
# bbduk.sh in=BOGR_RM06_S40_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM06_S40.txt out=BOGR_RM06_S40_T_Q_A.fastq
# bbduk.sh in=BOGR_RM07_S41_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM07_S41.txt out=BOGR_RM07_S41_T_Q_A.fastq
# bbduk.sh in=BOGR_RM08_S42_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM08_S42.txt out=BOGR_RM08_S42_T_Q_A.fastq
# bbduk.sh in=BOGR_RM09_S43_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM09_S43.txt out=BOGR_RM09_S43_T_Q_A.fastq
# bbduk.sh in=BOGR_RM10_S44_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM10_S44.txt out=BOGR_RM10_S44_T_Q_A.fastq
# bbduk.sh in=BOGR_RM11_S45_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM11_S45.txt out=BOGR_RM11_S45_T_Q_A.fastq
# bbduk.sh in=BOGR_RM12_S46_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM12_S46.txt out=BOGR_RM12_S46_T_Q_A.fastq
# bbduk.sh in=BOGR_RM13_S47_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM13_S47.txt out=BOGR_RM13_S47_T_Q_A.fastq
# bbduk.sh in=BOGR_RM14_S48_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM14_S48.txt out=BOGR_RM14_S48_T_Q_A.fastq
# bbduk.sh in=BOGR_RM15_S49_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM15_S49.txt out=BOGR_RM15_S49_T_Q_A.fastq
# bbduk.sh in=BOGR_RM16_S50_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM16_S50.txt out=BOGR_RM16_S50_T_Q_A.fastq
# bbduk.sh in=BOGR_RM17_S51_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RM17_S51.txt out=BOGR_RM17_S51_T_Q_A.fastq
# bbduk.sh in=BOGR_W01_S52_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W01_S52.txt out=BOGR_W01_S52_T_Q_A.fastq
# bbduk.sh in=BOGR_W02_S53_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W02_S53.txt out=BOGR_W02_S53_T_Q_A.fastq
# bbduk.sh in=BOGR_W03_S54_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W03_S54.txt out=BOGR_W03_S54_T_Q_A.fastq
# bbduk.sh in=BOGR_W04_S55_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W04_S55.txt out=BOGR_W04_S55_T_Q_A.fastq
# bbduk.sh in=BOGR_W05_S56_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W05_S56.txt out=BOGR_W05_S56_T_Q_A.fastq
# bbduk.sh in=BOGR_W06_S57_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W06_S57.txt out=BOGR_W06_S57_T_Q_A.fastq
# bbduk.sh in=BOGR_W07_S58_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W07_S58.txt out=BOGR_W07_S58_T_Q_A.fastq
# bbduk.sh in=BOGR_W08_S59_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W08_S59.txt out=BOGR_W08_S59_T_Q_A.fastq
# bbduk.sh in=BOGR_W09_S60_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W09_S60.txt out=BOGR_W09_S60_T_Q_A.fastq
# bbduk.sh in=BOGR_W10_S61_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W10_S61.txt out=BOGR_W10_S61_T_Q_A.fastq
# bbduk.sh in=BOGR_W11_S62_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W11_S62.txt out=BOGR_W11_S62_T_Q_A.fastq
# bbduk.sh in=BOGR_W12_S63_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W12_S63.txt out=BOGR_W12_S63_T_Q_A.fastq
# bbduk.sh in=BOGR_W13_S64_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W13_S64.txt out=BOGR_W13_S64_T_Q_A.fastq
# bbduk.sh in=BOGR_W14_S65_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W14_S65.txt out=BOGR_W14_S65_T_Q_A.fastq
# bbduk.sh in=BOGR_W15_S66_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W15_S66.txt out=BOGR_W15_S66_T_Q_A.fastq
# bbduk.sh in=BOGR_W16_S67_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_W16_S67.txt out=BOGR_W16_S67_T_Q_A.fastq
# bbduk.sh in=BOGR_WR01_S1_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR01_S1.txt out=BOGR_WR01_S1_T_Q_A.fastq
# bbduk.sh in=BOGR_WR02_S2_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR02_S2.txt out=BOGR_WR02_S2_T_Q_A.fastq
# bbduk.sh in=BOGR_WR03_S3_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR03_S3.txt out=BOGR_WR03_S3_T_Q_A.fastq
# bbduk.sh in=BOGR_WR04_S4_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR04_S4.txt out=BOGR_WR04_S4_T_Q_A.fastq
# bbduk.sh in=BOGR_WR05_S5_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR05_S5.txt out=BOGR_WR05_S5_T_Q_A.fastq
# bbduk.sh in=BOGR_WR06_S6_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR06_S6.txt out=BOGR_WR06_S6_T_Q_A.fastq
# bbduk.sh in=BOGR_WR07_S7_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR07_S7.txt out=BOGR_WR07_S7_T_Q_A.fastq
# bbduk.sh in=BOGR_WR08_S8_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR08_S8.txt out=BOGR_WR08_S8_T_Q_A.fastq
# bbduk.sh in=BOGR_WR09_S9_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR09_S9.txt out=BOGR_WR09_S9_T_Q_A.fastq
# bbduk.sh in=BOGR_WR10_S10_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR10_S10.txt out=BOGR_WR10_S10_T_Q_A.fastq
# bbduk.sh in=BOGR_WR11_S11_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR11_S11.txt out=BOGR_WR11_S11_T_Q_A.fastq
# bbduk.sh in=BOGR_WR12_S12_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR12_S12.txt out=BOGR_WR12_S12_T_Q_A.fastq
# bbduk.sh in=BOGR_WR13_S13_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR13_S13.txt out=BOGR_WR13_S13_T_Q_A.fastq
# bbduk.sh in=BOGR_WR14_S14_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR14_S14.txt out=BOGR_WR14_S14_T_Q_A.fastq
# bbduk.sh in=BOGR_WR15_S15_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR15_S15.txt out=BOGR_WR15_S15_T_Q_A.fastq
# bbduk.sh in=BOGR_WR16_S16_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR16_S16.txt out=BOGR_WR16_S16_T_Q_A.fastq
# bbduk.sh in=BOGR_WR17_S17_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_WR17_S17.txt out=BOGR_WR17_S17_T_Q_A.fastq
# bbduk.sh in=BOGR_A06_S73_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A06_S73.txt out=BOGR_A06_S73_T_Q_A.fastq
# bbduk.sh in=BOGR_A07_S74_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A07_S74.txt out=BOGR_A07_S74_T_Q_A.fastq
# bbduk.sh in=BOGR_A08_S75_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A08_S75.txt out=BOGR_A08_S75_T_Q_A.fastq
# bbduk.sh in=BOGR_A09_S76_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A09_S76.txt out=BOGR_A09_S76_T_Q_A.fastq
# bbduk.sh in=BOGR_A10_S77_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A10_S77.txt out=BOGR_A10_S77_T_Q_A.fastq
# bbduk.sh in=BOGR_A11_S78_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A11_S78.txt out=BOGR_A11_S78_T_Q_A.fastq
# bbduk.sh in=BOGR_A12_S79_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A12_S79.txt out=BOGR_A12_S79_T_Q_A.fastq
# bbduk.sh in=BOGR_A13_S80_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A13_S80.txt out=BOGR_A13_S80_T_Q_A.fastq
# bbduk.sh in=BOGR_A14_S81_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A14_S81.txt out=BOGR_A14_S81_T_Q_A.fastq
# bbduk.sh in=BOGR_A15_S82_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A15_S82.txt out=BOGR_A15_S82_T_Q_A.fastq
# bbduk.sh in=BOGR_A16_S83_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A16_S83.txt out=BOGR_A16_S83_T_Q_A.fastq
# bbduk.sh in=BOGR_A17_S84_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_A17_S84.txt out=BOGR_A17_S84_T_Q_A.fastq
# bbduk.sh in=BOGR_DM01_S118_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM01_S118.txt out=BOGR_DM01_S118_T_Q_A.fastq
# bbduk.sh in=BOGR_DM02_S119_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM02_S119.txt out=BOGR_DM02_S119_T_Q_A.fastq
# bbduk.sh in=BOGR_DM03_S120_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM03_S120.txt out=BOGR_DM03_S120_T_Q_A.fastq
# bbduk.sh in=BOGR_DM04_S121_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM04_S121.txt out=BOGR_DM04_S121_T_Q_A.fastq
# bbduk.sh in=BOGR_DM05_S122_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM05_S122.txt out=BOGR_DM05_S122_T_Q_A.fastq
# bbduk.sh in=BOGR_DM06_S123_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM06_S123.txt out=BOGR_DM06_S123_T_Q_A.fastq
# bbduk.sh in=BOGR_DM07_S124_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM07_S124.txt out=BOGR_DM07_S124_T_Q_A.fastq
# bbduk.sh in=BOGR_DM08_S125_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM08_S125.txt out=BOGR_DM08_S125_T_Q_A.fastq
# bbduk.sh in=BOGR_DM09_S126_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM09_S126.txt out=BOGR_DM09_S126_T_Q_A.fastq
# bbduk.sh in=BOGR_DM10_S127_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM10_S127.txt out=BOGR_DM10_S127_T_Q_A.fastq
# bbduk.sh in=BOGR_DM11_S128_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM11_S128.txt out=BOGR_DM11_S128_T_Q_A.fastq
# bbduk.sh in=BOGR_DM12_S129_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM12_S129.txt out=BOGR_DM12_S129_T_Q_A.fastq
# bbduk.sh in=BOGR_DM13_S130_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM13_S130.txt out=BOGR_DM13_S130_T_Q_A.fastq
# bbduk.sh in=BOGR_DM14_S131_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM14_S131.txt out=BOGR_DM14_S131_T_Q_A.fastq
# bbduk.sh in=BOGR_DM15_S132_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM15_S132.txt out=BOGR_DM15_S132_T_Q_A.fastq
# bbduk.sh in=BOGR_DM16_S133_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM16_S133.txt out=BOGR_DM16_S133_T_Q_A.fastq
# bbduk.sh in=BOGR_DM17_S134_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_DM17_S134.txt out=BOGR_DM17_S134_T_Q_A.fastq
# bbduk.sh in=BOGR_HV01_S102_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV01_S102.txt out=BOGR_HV01_S102_T_Q_A.fastq
# bbduk.sh in=BOGR_HV02_S103_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV02_S103.txt out=BOGR_HV02_S103_T_Q_A.fastq
# bbduk.sh in=BOGR_HV03_S104_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV03_S104.txt out=BOGR_HV03_S104_T_Q_A.fastq
# bbduk.sh in=BOGR_HV04_S105_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV04_S105.txt out=BOGR_HV04_S105_T_Q_A.fastq
# bbduk.sh in=BOGR_HV05_S106_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV05_S106.txt out=BOGR_HV05_S106_T_Q_A.fastq
# bbduk.sh in=BOGR_HV06_S107_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV06_S107.txt out=BOGR_HV06_S107_T_Q_A.fastq
# bbduk.sh in=BOGR_HV07_S108_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV07_S108.txt out=BOGR_HV07_S108_T_Q_A.fastq
# bbduk.sh in=BOGR_HV08_S109_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV08_S109.txt out=BOGR_HV08_S109_T_Q_A.fastq
# bbduk.sh in=BOGR_HV10_S110_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV10_S110.txt out=BOGR_HV10_S110_T_Q_A.fastq
# bbduk.sh in=BOGR_HV11_S111_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV11_S111.txt out=BOGR_HV11_S111_T_Q_A.fastq
# bbduk.sh in=BOGR_HV12_S112_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV12_S112.txt out=BOGR_HV12_S112_T_Q_A.fastq
# bbduk.sh in=BOGR_HV13_S113_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV13_S113.txt out=BOGR_HV13_S113_T_Q_A.fastq
# bbduk.sh in=BOGR_HV14_S114_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV14_S114.txt out=BOGR_HV14_S114_T_Q_A.fastq
# bbduk.sh in=BOGR_HV15_S115_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV15_S115.txt out=BOGR_HV15_S115_T_Q_A.fastq
# bbduk.sh in=BOGR_HV16_S116_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV16_S116.txt out=BOGR_HV16_S116_T_Q_A.fastq
# bbduk.sh in=BOGR_HV17_S117_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_HV17_S117.txt out=BOGR_HV17_S117_T_Q_A.fastq
# bbduk.sh in=BOGR_RC01_S135_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC01_S135.txt out=BOGR_RC01_S135_T_Q_A.fastq
# bbduk.sh in=BOGR_RC02_S136_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC02_S136.txt out=BOGR_RC02_S136_T_Q_A.fastq
# bbduk.sh in=BOGR_RC03_S137_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC03_S137.txt out=BOGR_RC03_S137_T_Q_A.fastq
# bbduk.sh in=BOGR_RC04_S138_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC04_S138.txt out=BOGR_RC04_S138_T_Q_A.fastq
# bbduk.sh in=BOGR_RC05_S139_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC05_S139.txt out=BOGR_RC05_S139_T_Q_A.fastq
# bbduk.sh in=BOGR_RC06_S140_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC06_S140.txt out=BOGR_RC06_S140_T_Q_A.fastq
# bbduk.sh in=BOGR_RC07_S141_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC07_S141.txt out=BOGR_RC07_S141_T_Q_A.fastq
# bbduk.sh in=BOGR_RC08_S142_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC08_S142.txt out=BOGR_RC08_S142_T_Q_A.fastq
# bbduk.sh in=BOGR_RC09_S143_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC09_S143.txt out=BOGR_RC09_S143_T_Q_A.fastq
# bbduk.sh in=BOGR_RC10_S144_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC10_S144.txt out=BOGR_RC10_S144_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS01_S85_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS01_S85.txt out=BOGR_SGS01_S85_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS02_S86_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS02_S86.txt out=BOGR_SGS02_S86_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS03_S87_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS03_S87.txt out=BOGR_SGS03_S87_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS04_S88_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS04_S88.txt out=BOGR_SGS04_S88_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS05_S89_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS05_S89.txt out=BOGR_SGS05_S89_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS06_S90_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS06_S90.txt out=BOGR_SGS06_S90_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS07_S91_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS07_S91.txt out=BOGR_SGS07_S91_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS08_S92_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS08_S92.txt out=BOGR_SGS08_S92_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS09_S93_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS09_S93.txt out=BOGR_SGS09_S93_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS10_S94_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS10_S94.txt out=BOGR_SGS10_S94_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS11_S95_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS11_S95.txt out=BOGR_SGS11_S95_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS12_S96_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS12_S96.txt out=BOGR_SGS12_S96_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS13_S97_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS13_S97.txt out=BOGR_SGS13_S97_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS14_S98_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS14_S98.txt out=BOGR_SGS14_S98_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS15_S99_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS15_S99.txt out=BOGR_SGS15_S99_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS16_S100_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS16_S100.txt out=BOGR_SGS16_S100_T_Q_A.fastq
# bbduk.sh in=BOGR_SGS17_S101_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SGS17_S101.txt out=BOGR_SGS17_S101_T_Q_A.fastq
# bbduk.sh in=BOGR_BG01_S203_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG01_S203.txt out=BOGR_BG01_S203_T_Q_A.fastq
# bbduk.sh in=BOGR_BG02_S204_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG02_S204.txt out=BOGR_BG02_S204_T_Q_A.fastq
# bbduk.sh in=BOGR_BG03_S205_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG03_S205.txt out=BOGR_BG03_S205_T_Q_A.fastq
# bbduk.sh in=BOGR_BG04_S206_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG04_S206.txt out=BOGR_BG04_S206_T_Q_A.fastq
# bbduk.sh in=BOGR_BG05_S207_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG05_S207.txt out=BOGR_BG05_S207_T_Q_A.fastq
# bbduk.sh in=BOGR_BG06_S208_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG06_S208.txt out=BOGR_BG06_S208_T_Q_A.fastq
# bbduk.sh in=BOGR_BG07_S209_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG07_S209.txt out=BOGR_BG07_S209_T_Q_A.fastq
# bbduk.sh in=BOGR_BG08_S210_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG08_S210.txt out=BOGR_BG08_S210_T_Q_A.fastq
# bbduk.sh in=BOGR_BG09_S211_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG09_S211.txt out=BOGR_BG09_S211_T_Q_A.fastq
# bbduk.sh in=BOGR_BG10_S212_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG10_S212.txt out=BOGR_BG10_S212_T_Q_A.fastq
# bbduk.sh in=BOGR_BG11_S213_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG11_S213.txt out=BOGR_BG11_S213_T_Q_A.fastq
# bbduk.sh in=BOGR_BG12_S214_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG12_S214.txt out=BOGR_BG12_S214_T_Q_A.fastq
# bbduk.sh in=BOGR_BG13_S215_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG13_S215.txt out=BOGR_BG13_S215_T_Q_A.fastq
# bbduk.sh in=BOGR_BG14_S216_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG14_S216.txt out=BOGR_BG14_S216_T_Q_A.fastq
# bbduk.sh in=BOGR_BT01_S169_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT01_S169.txt out=BOGR_BT01_S169_T_Q_A.fastq
# bbduk.sh in=BOGR_BT02_S170_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT02_S170.txt out=BOGR_BT02_S170_T_Q_A.fastq
# bbduk.sh in=BOGR_BT03_S171_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT03_S171.txt out=BOGR_BT03_S171_T_Q_A.fastq
# bbduk.sh in=BOGR_BT04_S172_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT04_S172.txt out=BOGR_BT04_S172_T_Q_A.fastq
# bbduk.sh in=BOGR_BT05_S173_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT05_S173.txt out=BOGR_BT05_S173_T_Q_A.fastq
# bbduk.sh in=BOGR_BT06_S174_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT06_S174.txt out=BOGR_BT06_S174_T_Q_A.fastq
# bbduk.sh in=BOGR_BT07_S175_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT07_S175.txt out=BOGR_BT07_S175_T_Q_A.fastq
# bbduk.sh in=BOGR_BT08_S176_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT08_S176.txt out=BOGR_BT08_S176_T_Q_A.fastq
# bbduk.sh in=BOGR_BT09_S177_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT09_S177.txt out=BOGR_BT09_S177_T_Q_A.fastq
# bbduk.sh in=BOGR_BT10_S178_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT10_S178.txt out=BOGR_BT10_S178_T_Q_A.fastq
# bbduk.sh in=BOGR_BT11_S179_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT11_S179.txt out=BOGR_BT11_S179_T_Q_A.fastq
# bbduk.sh in=BOGR_BT12_S180_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT12_S180.txt out=BOGR_BT12_S180_T_Q_A.fastq
# bbduk.sh in=BOGR_BT13_S181_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT13_S181.txt out=BOGR_BT13_S181_T_Q_A.fastq
# bbduk.sh in=BOGR_BT14_S182_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT14_S182.txt out=BOGR_BT14_S182_T_Q_A.fastq
# bbduk.sh in=BOGR_BT15_S183_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT15_S183.txt out=BOGR_BT15_S183_T_Q_A.fastq
# bbduk.sh in=BOGR_BT16_S184_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT16_S184.txt out=BOGR_BT16_S184_T_Q_A.fastq
# bbduk.sh in=BOGR_BT17_S185_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BT17_S185.txt out=BOGR_BT17_S185_T_Q_A.fastq
# bbduk.sh in=BOGR_CO01_S186_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO01_S186.txt out=BOGR_CO01_S186_T_Q_A.fastq
# bbduk.sh in=BOGR_CO02_S187_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO02_S187.txt out=BOGR_CO02_S187_T_Q_A.fastq
# bbduk.sh in=BOGR_CO03_S188_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO03_S188.txt out=BOGR_CO03_S188_T_Q_A.fastq
# bbduk.sh in=BOGR_CO04_S189_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO04_S189.txt out=BOGR_CO04_S189_T_Q_A.fastq
# bbduk.sh in=BOGR_CO05_S190_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO05_S190.txt out=BOGR_CO05_S190_T_Q_A.fastq
# bbduk.sh in=BOGR_CO06_S191_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO06_S191.txt out=BOGR_CO06_S191_T_Q_A.fastq
# bbduk.sh in=BOGR_CO07_S192_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO07_S192.txt out=BOGR_CO07_S192_T_Q_A.fastq
# bbduk.sh in=BOGR_CO08_S193_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO08_S193.txt out=BOGR_CO08_S193_T_Q_A.fastq
# bbduk.sh in=BOGR_CO09_S194_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO09_S194.txt out=BOGR_CO09_S194_T_Q_A.fastq
# bbduk.sh in=BOGR_CO10_S195_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO10_S195.txt out=BOGR_CO10_S195_T_Q_A.fastq
# bbduk.sh in=BOGR_CO11_S196_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO11_S196.txt out=BOGR_CO11_S196_T_Q_A.fastq
# bbduk.sh in=BOGR_CO12_S197_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO12_S197.txt out=BOGR_CO12_S197_T_Q_A.fastq
# bbduk.sh in=BOGR_CO13_S198_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO13_S198.txt out=BOGR_CO13_S198_T_Q_A.fastq
# bbduk.sh in=BOGR_CO14_S199_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO14_S199.txt out=BOGR_CO14_S199_T_Q_A.fastq
# bbduk.sh in=BOGR_CO15_S200_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO15_S200.txt out=BOGR_CO15_S200_T_Q_A.fastq
# bbduk.sh in=BOGR_CO16_S201_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO16_S201.txt out=BOGR_CO16_S201_T_Q_A.fastq
# bbduk.sh in=BOGR_CO17_S202_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CO17_S202.txt out=BOGR_CO17_S202_T_Q_A.fastq
# bbduk.sh in=BOGR_RC11_S145_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC11_S145.txt out=BOGR_RC11_S145_T_Q_A.fastq
# bbduk.sh in=BOGR_RC12_S146_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC12_S146.txt out=BOGR_RC12_S146_T_Q_A.fastq
# bbduk.sh in=BOGR_RC13_S147_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC13_S147.txt out=BOGR_RC13_S147_T_Q_A.fastq
# bbduk.sh in=BOGR_RC14_S148_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC14_S148.txt out=BOGR_RC14_S148_T_Q_A.fastq
# bbduk.sh in=BOGR_RC15_S149_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC15_S149.txt out=BOGR_RC15_S149_T_Q_A.fastq
# bbduk.sh in=BOGR_RC16_S150_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC16_S150.txt out=BOGR_RC16_S150_T_Q_A.fastq
# bbduk.sh in=BOGR_RC17_S151_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_RC17_S151.txt out=BOGR_RC17_S151_T_Q_A.fastq
# bbduk.sh in=BOGR_ST01_S152_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST01_S152.txt out=BOGR_ST01_S152_T_Q_A.fastq
# bbduk.sh in=BOGR_ST02_S153_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST02_S153.txt out=BOGR_ST02_S153_T_Q_A.fastq
# bbduk.sh in=BOGR_ST03_S154_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST03_S154.txt out=BOGR_ST03_S154_T_Q_A.fastq
# bbduk.sh in=BOGR_ST04_S155_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST04_S155.txt out=BOGR_ST04_S155_T_Q_A.fastq
# bbduk.sh in=BOGR_ST05_S156_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST05_S156.txt out=BOGR_ST05_S156_T_Q_A.fastq
# bbduk.sh in=BOGR_ST06_S157_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST06_S157.txt out=BOGR_ST06_S157_T_Q_A.fastq
# bbduk.sh in=BOGR_ST07_S158_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST07_S158.txt out=BOGR_ST07_S158_T_Q_A.fastq
# bbduk.sh in=BOGR_ST08_S159_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST08_S159.txt out=BOGR_ST08_S159_T_Q_A.fastq
# bbduk.sh in=BOGR_ST09_S160_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST09_S160.txt out=BOGR_ST09_S160_T_Q_A.fastq
# bbduk.sh in=BOGR_ST10_S161_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST10_S161.txt out=BOGR_ST10_S161_T_Q_A.fastq
# bbduk.sh in=BOGR_ST11_S162_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST11_S162.txt out=BOGR_ST11_S162_T_Q_A.fastq
# bbduk.sh in=BOGR_ST12_S163_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST12_S163.txt out=BOGR_ST12_S163_T_Q_A.fastq
# bbduk.sh in=BOGR_ST13_S164_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST13_S164.txt out=BOGR_ST13_S164_T_Q_A.fastq
# bbduk.sh in=BOGR_ST14_S165_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST14_S165.txt out=BOGR_ST14_S165_T_Q_A.fastq
# bbduk.sh in=BOGR_ST15_S166_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST15_S166.txt out=BOGR_ST15_S166_T_Q_A.fastq
# bbduk.sh in=BOGR_ST16_S167_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST16_S167.txt out=BOGR_ST16_S167_T_Q_A.fastq
# bbduk.sh in=BOGR_ST17_S168_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_ST17_S168.txt out=BOGR_ST17_S168_T_Q_A.fastq
# bbduk.sh in=BOGR_BG15_S217_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG15_S217.txt out=BOGR_BG15_S217_T_Q_A.fastq
# bbduk.sh in=BOGR_BG16_S218_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG16_S218.txt out=BOGR_BG16_S218_T_Q_A.fastq
# bbduk.sh in=BOGR_BG17_S219_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_BG17_S219.txt out=BOGR_BG17_S219_T_Q_A.fastq
# bbduk.sh in=BOGR_CI01_S237_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI01_S237.txt out=BOGR_CI01_S237_T_Q_A.fastq
# bbduk.sh in=BOGR_CI02_S238_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI02_S238.txt out=BOGR_CI02_S238_T_Q_A.fastq
# bbduk.sh in=BOGR_CI03_S239_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI03_S239.txt out=BOGR_CI03_S239_T_Q_A.fastq
# bbduk.sh in=BOGR_CI04_S240_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI04_S240.txt out=BOGR_CI04_S240_T_Q_A.fastq
# bbduk.sh in=BOGR_CI05_S241_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI05_S241.txt out=BOGR_CI05_S241_T_Q_A.fastq
# bbduk.sh in=BOGR_CI06_S242_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI06_S242.txt out=BOGR_CI06_S242_T_Q_A.fastq
# bbduk.sh in=BOGR_CI07_S243_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI07_S243.txt out=BOGR_CI07_S243_T_Q_A.fastq
# bbduk.sh in=BOGR_CI08_S244_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI08_S244.txt out=BOGR_CI08_S244_T_Q_A.fastq
# bbduk.sh in=BOGR_CI09_S245_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI09_S245.txt out=BOGR_CI09_S245_T_Q_A.fastq
# bbduk.sh in=BOGR_CI10_S246_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI10_S246.txt out=BOGR_CI10_S246_T_Q_A.fastq
# bbduk.sh in=BOGR_CI11_S247_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI11_S247.txt out=BOGR_CI11_S247_T_Q_A.fastq
# bbduk.sh in=BOGR_CI12_S248_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI12_S248.txt out=BOGR_CI12_S248_T_Q_A.fastq
# bbduk.sh in=BOGR_CI13_S249_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI13_S249.txt out=BOGR_CI13_S249_T_Q_A.fastq
# bbduk.sh in=BOGR_CI14_S250_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI14_S250.txt out=BOGR_CI14_S250_T_Q_A.fastq
# bbduk.sh in=BOGR_CI15_S251_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI15_S251.txt out=BOGR_CI15_S251_T_Q_A.fastq
# bbduk.sh in=BOGR_CI16_S252_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI16_S252.txt out=BOGR_CI16_S252_T_Q_A.fastq
# bbduk.sh in=BOGR_CI17_S253_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CI17_S253.txt out=BOGR_CI17_S253_T_Q_A.fastq
# bbduk.sh in=BOGR_CP01_S271_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP01_S271.txt out=BOGR_CP01_S271_T_Q_A.fastq
# bbduk.sh in=BOGR_CP02_S272_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP02_S272.txt out=BOGR_CP02_S272_T_Q_A.fastq
# bbduk.sh in=BOGR_CP03_S273_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP03_S273.txt out=BOGR_CP03_S273_T_Q_A.fastq
# bbduk.sh in=BOGR_CP04_S274_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP04_S274.txt out=BOGR_CP04_S274_T_Q_A.fastq
# bbduk.sh in=BOGR_CP05_S275_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP05_S275.txt out=BOGR_CP05_S275_T_Q_A.fastq
# bbduk.sh in=BOGR_CP06_S276_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP06_S276.txt out=BOGR_CP06_S276_T_Q_A.fastq
# bbduk.sh in=BOGR_CP07_S277_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP07_S277.txt out=BOGR_CP07_S277_T_Q_A.fastq
# bbduk.sh in=BOGR_CP08_S278_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP08_S278.txt out=BOGR_CP08_S278_T_Q_A.fastq
# bbduk.sh in=BOGR_CP09_S279_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP09_S279.txt out=BOGR_CP09_S279_T_Q_A.fastq
# bbduk.sh in=BOGR_CP10_S280_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP10_S280.txt out=BOGR_CP10_S280_T_Q_A.fastq
# bbduk.sh in=BOGR_CP11_S281_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP11_S281.txt out=BOGR_CP11_S281_T_Q_A.fastq
# bbduk.sh in=BOGR_CP12_S282_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP12_S282.txt out=BOGR_CP12_S282_T_Q_A.fastq
# bbduk.sh in=BOGR_CP13_S283_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP13_S283.txt out=BOGR_CP13_S283_T_Q_A.fastq
# bbduk.sh in=BOGR_CP14_S284_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP14_S284.txt out=BOGR_CP14_S284_T_Q_A.fastq
# bbduk.sh in=BOGR_CP15_S285_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP15_S285.txt out=BOGR_CP15_S285_T_Q_A.fastq
# bbduk.sh in=BOGR_CP16_S286_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP16_S286.txt out=BOGR_CP16_S286_T_Q_A.fastq
# bbduk.sh in=BOGR_CP17_S287_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_CP17_S287.txt out=BOGR_CP17_S287_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ01_S254_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ01_S254.txt out=BOGR_KNZ01_S254_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ02_S255_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ02_S255.txt out=BOGR_KNZ02_S255_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ03_S256_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ03_S256.txt out=BOGR_KNZ03_S256_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ04_S257_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ04_S257.txt out=BOGR_KNZ04_S257_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ05_S258_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ05_S258.txt out=BOGR_KNZ05_S258_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ06_S259_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ06_S259.txt out=BOGR_KNZ06_S259_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ07_S260_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ07_S260.txt out=BOGR_KNZ07_S260_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ08_S261_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ08_S261.txt out=BOGR_KNZ08_S261_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ09_S262_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ09_S262.txt out=BOGR_KNZ09_S262_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ10_S263_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ10_S263.txt out=BOGR_KNZ10_S263_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ11_S264_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ11_S264.txt out=BOGR_KNZ11_S264_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ12_S265_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ12_S265.txt out=BOGR_KNZ12_S265_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ13_S266_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ13_S266.txt out=BOGR_KNZ13_S266_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ14_S267_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ14_S267.txt out=BOGR_KNZ14_S267_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ15_S268_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ15_S268.txt out=BOGR_KNZ15_S268_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ16_S269_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ16_S269.txt out=BOGR_KNZ16_S269_T_Q_A.fastq
# bbduk.sh in=BOGR_KNZ17_S270_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_KNZ17_S270.txt out=BOGR_KNZ17_S270_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV01_S220_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV01_S220.txt out=BOGR_SEV01_S220_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV02_S221_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV02_S221.txt out=BOGR_SEV02_S221_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV03_S222_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV03_S222.txt out=BOGR_SEV03_S222_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV04_S223_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV04_S223.txt out=BOGR_SEV04_S223_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV05_S224_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV05_S224.txt out=BOGR_SEV05_S224_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV06_S225_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV06_S225.txt out=BOGR_SEV06_S225_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV07_S226_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV07_S226.txt out=BOGR_SEV07_S226_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV08_S227_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV08_S227.txt out=BOGR_SEV08_S227_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV09_S228_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV09_S228.txt out=BOGR_SEV09_S228_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV10_S229_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV10_S229.txt out=BOGR_SEV10_S229_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV11_S230_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV11_S230.txt out=BOGR_SEV11_S230_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV12_S231_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV12_S231.txt out=BOGR_SEV12_S231_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV13_S232_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV13_S232.txt out=BOGR_SEV13_S232_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV14_S233_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV14_S233.txt out=BOGR_SEV14_S233_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV15_S234_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV15_S234.txt out=BOGR_SEV15_S234_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV16_S235_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV16_S235.txt out=BOGR_SEV16_S235_T_Q_A.fastq
# bbduk.sh in=BOGR_SEV17_S236_T_Q.fastq ref=adaptors.fasta k=12 stats=stats_BOGR_SEV17_S236.txt out=BOGR_SEV17_S236_T_Q_A.fastq
